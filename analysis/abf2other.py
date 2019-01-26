#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""abf2other.py: 
"""
    
__author__           = "Dilawar Singh"
__copyright__        = "Copyright 2017-, Dilawar Singh"
__version__          = "1.0.0"
__maintainer__       = "Dilawar Singh"
__email__            = "dilawars@ncbs.res.in"
__status__           = "Development"

import sys
import os
import pyabf 
import numpy as np
import pandas as pd

def extractData(abf):
    df = pd.DataFrame()
    header = abf.headerText
    for sl in abf.sweepList:
        abf.setSweep(sl)
        x, y = abf.sweepX, abf.sweepY
        df[ f'Time' ] = x
        df[ f'Trace {sl}' ] = y
    return df

def plotFigure( df, outfile ):
    import matplotlib.pyplot as plt
    df.plot()
    plt.savefig( outfile )
    print( f'[INFO] Saved to {outfile}' )

def saveData( df, outfile ):
    df.to_csv( outfile, index = False )
    print( f'[INFO] Saved to {outfile}' )

def main(args):
    abf = pyabf.ABF( args.input )
    abf.setSweep( args.sweep )
    ext = args.output.split( '.' )[-1]
    df = extractData(abf)
    if ext in [ 'png', 'pdf', 'svg', 'eps', 'jpg']:
        print( 'Plotting images' )
        plotFigure( df, args.output )
    elif ext in [ 'dat', 'csv', 'txt']:
        saveData( df, args.output )

if __name__ == '__main__':
    import argparse
    # Argument parser.
    description = '''ABF format to other formats.'''
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('--input', '-i'
        , required = True
        , help = 'Input file'
        )
    parser.add_argument('--output', '-o'
        , required = False
        , help = 'Output file'
        )
    parser.add_argument( '--sweep', '-s'
        , required = False
        , default = 0
        , type = int
        , help = 'User defined sweep. Try to guess it.'
        )
    class Args: pass 
    args = Args()
    parser.parse_args(namespace=args)
    main(args)
