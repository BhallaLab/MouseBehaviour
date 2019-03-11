#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""area_n_points.py: """
    
__author__           = "Dilawar Singh"
__copyright__        = "Copyright 2017-, Dilawar Singh"
__version__          = "1.0.0"
__maintainer__       = "Dilawar Singh"
__email__            = "dilawars@ncbs.res.in"
__status__           = "Development"

import math
import io
import pandas as pd
import numpy as np
import cv2

def theta(x2, y2, x1, y1):
    return math.atan2(y2-y1, x2-x1)

def sort_points(ps, x0, y0):
    psorted = sorted(ps, key=lambda p: theta(p[0], p[1], x0, y0))
    return psorted

def areaTriangle(p1, p2, p3):
    (x1, y1), (x2,y2), (x3,y3) = p1, p2, p3
    return abs(x1*(y2-y3)+x2*(y3-y1)+x3*(y1-y2))

def compute_area( X, Y ):
    x0, y0 = np.mean(X), np.mean(Y)
    ps = zip(X, Y)
    ps = sort_points(ps, x0, y0)
    area = 0
    # Now create triangles using two points and x0, y0
    for p1, p2 in zip(ps, ps[1:]+[ps[0]]):
        area += areaTriangle(p1, p2, (x0,y0))
    return area

def plot_points(X, Y, ax):
    import random
    x0, y0 = np.mean(X), np.mean(Y)
    ax.plot(X, Y, 'o' )
    ax.plot( [x0], [y0], 'x' )
    sortedPs = sort_points(zip(X,Y), x0, y0)
    for i, (p1, p2) in enumerate(zip(sortedPs, sortedPs[1:]+[sortedPs[0]])):
        color = (random.random(), random.random(), random.random())
        (x1, y1), (x2, y2) = p1, p2
        ax.plot( [x1, x2], [y1, y2], color=color )
        ax.plot( [x0, x1], [y0, y1], color=color )
        #  ax.annotate(str(i), (x1, y1))

def plot(data, outfile):
    import matplotlib.pyplot as plt
    plt.figure(figsize=(12,6))
    XS = data.filter(regex='x').values
    YS = data.filter(regex='y').values
    area = data['area']
    plt.subplot(121)
    plt.plot(area)
    plt.xlabel('Frame Index')
    plt.title('Area')

    ax = plt.subplot(122)
    xmax, ymax = 400, 800
    img = np.zeros(shape=(xmax,ymax, 3))
    for i, (xs, ys) in enumerate(zip(XS, YS)):
        assert len(xs) == len(ys)
        assert len(xs) == 6
        #  plot_points(xs, ys, ax)
        pts = np.array([(int(x[0]), int(x[1])) for x in zip(xs,ys)])
        cv2.fillConvexPoly(img, pts, (10*i,10*i,10*i) )
    ax.imshow(img, interpolation='none', aspect='auto')
    plt.tight_layout()
    plt.savefig(outfile)
    

def process(df, args):
    df = df.filter(regex='a?tg')
    ss = []
    for i, row in df.iterrows():
        r = df.iloc[i].values
        xs = list(r[0::3])
        ys = list(r[1::3])
        ar = compute_area(xs, ys)
        assert len(xs) == len(ys), \
                "Header of csv are screwed up. I can't understadnd what is what now!"
        keys = ['x%d'%i for i,x in enumerate(xs)]
        keys += ['y%d'%i for i,x in enumerate(ys)]
        keys.append('area')
        vals = list(xs) + list(ys) + [ar]
        assert len(keys) == len(vals), (len(keys), len(vals))
        data = dict(zip(keys, vals))
        s = pd.Series(data)
        ss.append(s)
    res =  pd.DataFrame(ss)
    outfile = '%s.out.csv' % args.input
    res.to_csv(outfile, sep=',', index=False)
    if args.output:
        plot(res, args.output)
    print('[DONE] Saved to %s' % outfile)


def reformat(args):
    with open(args.input, 'r') as f:
        lines = f.read().split('\n')
    headers = lines[:args.num_header_rows]
    hs = list(zip(*[x.split(',') for x in headers]))
    hs = ','.join(['+'.join(x) for x in hs])
    res = lines[args.num_header_rows:]
    return hs + '\n' + '\n'.join(res)

def main(args):
    print( '[INFO] This version assumes that CSV has 3 header rows. '
            ' Who does that ☹ !'
            )
    fstr = reformat(args)
    df = pd.read_csv(io.StringIO(fstr))
    process(df, args)

if __name__ == '__main__':
    import argparse
    # Argument parser.
    description = '''Compute area of contained by n points:'''
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('--input', '-i'
        , required=True
        , help='Input file'
        )
    parser.add_argument('--num-header-rows', '-nh'
        , required=False, default=3, type=int
        , help='Number of header rows.'
        )
    parser.add_argument('--output', '-o'
        , required = False, default = ''
        , help = 'Plot the PNG file.'
        )
    class Args: pass 
    args = Args()
    parser.parse_args(namespace=args)
    main(args)
