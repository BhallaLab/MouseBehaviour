"""read_mouse_delta.py: 

"""
from __future__ import print_function
    
__author__           = "Dilawar Singh"
__copyright__        = "Copyright 2017-, Dilawar Singh"
__version__          = "1.0.0"
__maintainer__       = "Dilawar Singh"
__email__            = "dilawars@ncbs.res.in"
__status__           = "Development"

import sys
import struct
import os
import time
import math
import io
import Queue
import fcntl 
import datetime

user_ = os.environ.get( 'USER', ' ' )

user_interrupt_ = False
trajs = [ (0,0,0) ] * 10
lastT_ = 0.0

f_ = None
q_ = [ (0,0,0) ]


def getMouseEvent( mouseF, q ):
    global user_interrupt_
    global sock_
    if user_interrupt_:
        return 

    # This is too fast. Probably not a good idea. Use os.read( ).
    fd = mouseF.fileno()
    flag = fcntl.fcntl(fd, fcntl.F_GETFL)
    fcntl.fcntl(fd, fcntl.F_SETFL, flag | os.O_NONBLOCK)
    flag = fcntl.fcntl(fd, fcntl.F_GETFL)
    buf = mouseF.read(3);
    t = time.time( )
    if buf:
        x,y = struct.unpack( "bb", buf[1:] );
        q.append( (t, x, y) )
    else:
        q.append( (t,0,0) )
    # Essential to sleep for some time.
    time.sleep( 1e-3 )

def getMousePos( q ):
    global user_interrupt_
    global lastT_
    if user_interrupt_:
        sock_.close( )
        return
    val = q.pop( )
    t1, dx, dy = val
    t0, x0, y0 = trajs[-1]
    trajs.append( (t1, x0 + dx, y0 + dy) )
    trajs.pop( 0 )
    res = compute_velocity_and_dir( trajs )
    if t1 > lastT_ + 5e-3 :
        return '%.6f,%.3f,%.3f' % (t1, res[0], res[1] )
        lastT_ = t1

def compute_velocity_and_dir( trajs ):
    vels, dirs = [ ], [ ]
    for i, (t, x, y) in enumerate(trajs[1:]):
        t0, x0, y0 = trajs[i]
        if t > t0:
            v = ((x - x0 ) ** 2.0 + (y-y0)**2.0) ** 0.5 / (t-t0)
            theta = (y - y0) / max(1e-12, (x - x0))
            d = math.atan( theta )
            vels.append( v )
            dirs.append( d )
        else:
            vels.append( 0 )
            dirs.append( 0 )
    # average direction
    return sum( vels ) / len(vels), sum( dirs ) / len(dirs)

def main( path ):
    global user_interrupt_
    global sock_
    global f_, q_
    global mouseFile_
    if f_ is None:
        f_ = io.open( path, "rb" ) 

    getMouseEvent(f_, q_)
    now = datetime.datetime.now().isoformat()
    r = getMousePos( q_)
    txt = now + ',' + r
    ## debug only.
    #with open( '__mouse.txt' , 'a' ) as mouseFile_:
    #    mouseFile_.write( txt + '\n' )
    return txt

if __name__ == '__main__':
    path = sys.argv[1]
    while 1:
        print( main( path ) )

