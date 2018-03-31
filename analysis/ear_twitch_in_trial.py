#!/usr/bin/env python3
    
__author__           = "Dilawar Singh"
__copyright__        = "Copyright 2017-, Dilawar Singh"
__version__          = "1.0.0"
__maintainer__       = "Dilawar Singh"
__email__            = "dilawars@ncbs.res.in"
__status__           = "Development"

import sys
import os
import datetime
import numpy as np
import cv2 
import glob
from libtiff import TIFF

import matplotlib as mpl
import matplotlib.pyplot as plt
try:
    mpl.style.use( 'bmh' )
except Exception as e:
    pass

def crop( frame ):
    _, contours, _ = cv2.findContours(frame, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE)
    best_box=[-1,-1,-1,-1]
    for c in contours:
       x,y,w,h = cv2.boundingRect(c)
       if best_box[0] < 0:
           best_box=[x,y,x+w,y+h]
           continue

       if x<best_box[0]:
           best_box[0]=x
       if y<best_box[1]:
           best_box[1]=y
       if x+w>best_box[2]:
           best_box[2]=x+w
       if y+h>best_box[3]:
           best_box[3]=y+h
    a, b, c, d = best_box
    return frame[b:d,a:c]


def gt(dt_str):
    dt, _, us = dt_str.partition(".")
    dt = datetime.datetime.strptime(dt, "%Y-%m-%dT%H:%M:%S")
    us = int(us.rstrip("Z"), 10)
    return dt + datetime.timedelta(microseconds=us)

def goodFeaturesToTrack( frame, plot = True ):
    corners = cv2.goodFeaturesToTrack(frame, 25, 0.01, 10)
    if plot:
        corners = np.int0(corners)
        for i in corners:
            x,y = i.ravel()
            cv2.circle(frame, (x,y), 3, 255, -1)
    return frame, corners

def process_frame( frame ):
    #  frame = cv2.bilateralFilter( frame, 9, 75, 75 )
    u, v = np.mean( frame ), np.std( frame )
    frame[ frame < (u + v) ] = 0
    frame = crop( frame )
    return frame

def process_tiff( tifffile, ax = None ):
    print('Analyzing %s' % tifffile)
    tf = TIFF.open( tifffile )
    frames = list( tf.iter_images( ) )
    o = 50
    xvec, yvec, imgs = [], [], [ ]

    #  plt.subplot( 2, 1, 1 )
    for i, frame in enumerate(frames):
        f = frame.copy()
        print( "[INFO ] Processing frame %d/%d" % (i,len(frames)) )
        data = ''.join( [chr(x) for x in f[0,:] ] )
        data = data.split( ',' )
        xvec.append( gt( data[0] ) )
        f = f[o:-o,o:-o]
        res = process_frame( f )
        yvec.append( np.sum( res ) )
        if i % 4 == 0:
            imgs.append( cv2.resize(frame, (0,0), fx=0.25, fy=0.25) )
        cv2.imshow( 'frame', res )
        cv2.waitKey( 1 )

    if ax:
        ax.plot( xvec, yvec )
        ax.set_xlabel( 'Time' )
        ax.set_ylabel( 'Sum of surface' )

    return xvec, yvec

def main( dirname ):
    files = glob.glob( '%s/*.tif*' % dirname )
    img = [ ]
    for i, f in enumerate(files):
        x, y = process_tiff( f )
        img.append( y )

    plt.imshow( y, interpolation = 'none', aspect = 'auto' )
    plt.colorbar( )
    outfile = os.path.join( dirname, 'summary.png' )
    plt.savefig( outfile )
    print( "[INFO ] Saved to %s" % outfile )


if __name__ == '__main__':
    main(sys.argv[1])

