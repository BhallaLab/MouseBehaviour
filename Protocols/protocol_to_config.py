#!/usr/bin/env python3
"""protocol_to_config.py: 
"""
    
__author__           = "Dilawar Singh"
__copyright__        = "Copyright 2017-, Dilawar Singh"
__version__          = "1.0.0"
__maintainer__       = "Dilawar Singh"
__email__            = "dilawars@ncbs.res.in"
__status__           = "Development"

import sys
import os
import csv
import re
import random
import typing as T

sdir_ = os.path.dirname(os.path.realpath(__file__ ))
class Args: pass 
args = Args()

Time = T.TypeVar('T', int, str)

def error(msg):
    print(msg, file=sys.stderr)

class Interval():

    def __init__(self, name='', start=0, end=0):
        self.name : str = name
        self.start : Time= start
        self.end : Time = end
        self.value : str = 'NONE'
        self.evaluated : bool = False

    def eval(self):
        #  print( f"BEFORE: {self.start} and {self.end}" )
        #  print( type(self.start), type(self.end))
        self.start = int(eval('%s'%self.start))
        self.end = int(eval('%s'%self.end))
        self.evaluated = True
        #  print('AFTER', self.start, self.end)

    def __repr__(self):
        return f"{self.start},{self.end}"

def csvFile(protoFile, whichProtocol, res):
    protocols = {}
    with open(protoFile, 'r') as f:
        csvdict = csv.DictReader(f)
        for row in csvdict:
            protocols[row['CODE']] = row
    if whichProtocol not in protocols:
        res.append( "Protocol '%s' is not available." % whichProtocol )
        res.append( "| Available protcols are: %s" % ','.join(protocols.keys()))
        return False

    protocol = protocols[whichProtocol]
    for k, v in protocol.items():
        # If v is string, turn it into a C like string.
        try:
            v = eval(v)
        except Exception as e:
            v = '"%s"' % v
        k = k.replace( '-', '_' )
        k = k.replace( ' ', '_' )
        # The US value can not be longer than 10 chars. else arduino code will
        # break.
        if k.strip() == "USValue":
            v = v[:10]
        res.append( '#define PROTO_%s      %s' % (k,v))
    return True

def searchAndReplace(expr, intervals):
    iNames = list(intervals.keys())
    for iName in iNames:
        interval = intervals[iName]
        if interval.evaluated:
            # This interval expression is evaluated, find it and replace it by
            # its start/end value. 
            expr = expr.replace(f'{iName}.start', '%s'%interval.start) 
            expr = expr.replace(f'{iName}.end', '%s'%interval.end) 
    return expr

def evaluateAllIntervals(intervals):
    allEvaluated = False
    nStep = 0
    while not allEvaluated:
        nStep += 1
        if nStep > 100:
            print(f'#error "Could not evaluate protocol intervals.'
                    ' Please check for syntax error."'
                    )
            return False
            
        allEvaluated = True
        for iName, interval in intervals.items():
            if interval.evaluated:
                continue
            interval.start = searchAndReplace(interval.start, intervals)
            interval.end = searchAndReplace(interval.end, intervals)
            try:
                interval.eval()
            except Exception as e:
                error(f'Error in evaluation: {e}')
                interval.evaluated = False
                allEvaluated = False
    return True

def protoToConfig(proto, res):
    res.append('// Description: ' + proto.get('description', 'Not available'))
    intDict = proto['intervals']
    intNames = list(intDict.keys())
    intervals = {}
    for intName in intNames:
        i = Interval(intName, intDict[intName]['start'], intDict[intName]['end'])
        i.value = intDict[intName].get('value', 'NONE')
        try:
            i.eval()
        except Exception as e:
            i.evaluated = False
        intervals[intName] = i

    # Recursively evaluate all expression.
    res = evaluateAllIntervals(intervals)
    # If evaluation is successful. Its time to create header file with
    # appropriate data structures.
    if res:
        return intervals
    return None

def ymlFile(filepath, protocol, res):
    import yaml
    data = {}
    with open(filepath, 'r') as f:
        data = yaml.safe_load(f)

    if protocol not in data:
        error(f'[ERROR] {protocol} not found in {filepath}')
        error(f'[INFO ] Available protocols are: %s'%', '.join(data.keys()))
        return False

    res.append(f'\n// PROTOCOL: {protocol}')
    res.append(f'#define PROTO_CODE {protocol}')
    proto = data[protocol]
    numTrials = proto.get('NumTrialInABlock', 60)
    res.append(f'#define PROTO_NumTrialsInABlock {numTrials}')

    intervals = protoToConfig(proto, res)
    if intervals is None:
        return False
    res.append(''
            'struct Interval {\n'
            '    char name[5];\n'
            '    int start;\n'
            '    int end;\n'
            '    char value[10];\n'
            '    void (*callbackStart) ();\n'
            '    void (*callbackEnd) ();\n'
            '};')

    res.append(f'Interval intervals_[{len(intervals)}];')
    for i, (iName, interval) in enumerate(intervals.items()):
        res.append(f'struct Interval int{iName} = {{ .name="{interval.name}"'
                f', .start = {interval.start}, .end = {interval.end}'
                f', .value = "{interval.value}" '
                f', .callbackStart = func{iName}Start, .callbackEnd = func{iName}End }};'
                )
        res.append(f'intervals_[{i}] = int{iName};')
    return True


def main():
    global args
    res = ['// These variables are generated by cmake and %s'%__file__]
    res.append('// Input file: variables are generated by cmake + %s'%args.input)
    res.append('\n')
    res.append('#ifndef XXX_CONFIG_H')
    res.append('#define XXX_CONFIG_H')
    res.append('\n\n#include "callback.h"    // pre-defined callback. ')
    ext = args.input.split('.')[-1]
    if ext == 'csv':
        status = csvFile(args.input, args.protocol, res)
    else:
        status = ymlFile(args.input, args.protocol, res)

    res.append('\n\n#endif')
    if args.output is None:
        print('\n'.join(res), file=sys.stdout)
    else:
        with open(args.output, 'w') as f:
            f.write('\n'.join(res))
        print( f"[INFO ] Wrote to {args.output}" )
    return 0 if status else 1

if __name__ == '__main__':
    import argparse
    # Argument parser.
    description = '''Parse protocol files and generate header for Arduino'''
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('input', help = 'Input file')
    parser.add_argument('protocol', help = 'Which protocol?')
    parser.add_argument('--output', '-o', default = None 
            , help = 'Output file?'
            )
    parser.parse_args(namespace=args)
    main()
