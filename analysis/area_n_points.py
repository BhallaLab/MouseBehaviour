"""area_n_points.py: 

"""
    
__author__           = "Dilawar Singh"
__copyright__        = "Copyright 2017-, Dilawar Singh"
__version__          = "1.0.0"
__maintainer__       = "Dilawar Singh"
__email__            = "dilawars@ncbs.res.in"
__status__           = "Development"

import sys
import os
import math
import numpy as np


def theta(x2, y2, x1, y1):
    return math.atan2(y2-y1, x2-x1)

def sort_points(ps, x0, y0):
    psorted = sorted(ps, key=lambda p: theta(p[0], p[1], x0, y0))
    return psorted

def areaTriangle( p1, p2, p3 ):
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

def test():
    import random
    import matplotlib as mpl
    import matplotlib.pyplot as plt
    #  mpl.style.use( ['bmh', 'fivethirtyeight'] )
    N = 6
    X = np.random.randint(0,  200, N)
    Y = np.random.randint(0, 200, N)
    x0, y0 = np.mean(X), np.mean(Y)
    plt.subplot(121)
    plt.plot(X, Y, 'o' )
    plt.plot( [x0], [y0], 'x' )

    plt.subplot(122)
    sortedPs = sort_points(zip(X,Y), x0, y0)

    plt.plot( [x0], [y0], 'x' )
    for i, (p1, p2) in enumerate(zip(sortedPs, sortedPs[1:]+[sortedPs[0]])):
        color = (random.random(), random.random(), random.random())
        (x1, y1), (x2, y2) = p1, p2
        plt.plot( [x1, x2], [y1, y2], color=color )
        plt.plot( [x0, x1], [y0, y1], color=color )
        plt.annotate(str(i), (x1, y1))

    plt.savefig( '%s.png' % __file__ )

    a = compute_area( X, Y )
    print( 'Area is %f' % a )

def main():
    test()

if __name__ == '__main__':
    main()

