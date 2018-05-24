#!/usr/bin/env python

"""analyze_trial.py: 

Analyze each trial.

"""
    
__author__           = "Dilawar Singh"
__copyright__        = "Copyright 2016, Dilawar Singh "
__credits__          = ["NCBS Bangalore"]
__license__          = "GNU GPL"
__version__          = "1.0.0"
__maintainer__       = "Dilawar Singh"
__email__            = "dilawars@ncbs.res.in"
__status__           = "Development"

import os
import sys
import analyze_trial_video 
try:
    import cPickle as pickle
except ImportError as e:
    import pickle
import numpy as np
import config

import matplotlib as mpl
import matplotlib.pyplot as plt
mpl.style.use( 'seaborn-talk' )
mpl.rcParams['axes.linewidth'] = 0.2
mpl.rcParams['text.usetex'] = False

trial_data_ = [ ]

def tick_for_label( label, labels, ticks ):
    return np.interp( label, labels, ticks )

def computeXTicks( time, tstep = 100 ):
    """
    Put a tick at 100ms
    """
    time = 1000 * time
    xticks = np.arange( 0, len(time), 1 )
    nticks = int( ( time.max() - time.min( ) ) / tstep )

    step = int( len( time ) / nticks)

    xticks = xticks[::step]
    labels = time[::step]

    newrange = np.int32( [ time.min( ) /100.0, time.max( )/100.0 ] ) * 100.0
    newlabels = np.arange( newrange[0], newrange[1], tstep )

    newIndex = np.rint( np.interp( newlabels, labels, xticks ) )
    return newIndex, newlabels


def process( trialdir ):
    global trial_data_
    tiffs = [ ]
    for d, sd, fs in os.walk( trialdir ):
        for f in fs:
            ext = f.split( '.' )[-1]
            if ext in [ 'tiff', 'tif' ]:
                tiffs.append( os.path.join( d, f ) )

    resdir = os.path.join( trialdir, config.tempdir )
    if not os.path.exists( resdir ):
        os.makedirs( resdir )

    for f in sorted( tiffs ):
        pickleFile = os.path.join(resdir, os.path.basename( '%s.pickle' % f))
        if not os.path.exists( pickleFile ):
            res = analyze_trial_video.process( f, plot = True )
            trial_data_.append( (f, res) )
        else:
            print( 'Pickle file is found. Reusing it' )
            with open( pickleFile, 'rb' ) as pF:
                res = pickle.load( pF )
                trial_data_.append( (f, res) )

    times, allBlinks, probeTrial = [ ], [ ], [ ]
    for i, (f, d) in enumerate(trial_data_):
        print(d.keys())
        blinks = d[ 'blinks' ]
        tvec = d['time']
        cs = d['cs']
        trialType = d['trial_type']
        print('[INFO] Trial type is %s' % trialType )
        tvec = list( map(lambda x: (x - cs[0]).total_seconds( ), tvec) )
        duration = 1000 * (tvec[-1] - tvec[0])
        if duration < 900:
            print( 
                '[WARN] %s was shorter than 900 ms. Duration %d' % (f,duration) 
                )
        times.append( tvec )
        allBlinks.append( d['blinks'] )
        if d['is_probe'] == True:
            probeTrial.append( i )
        

    tmins, tmaxs = [ ], [ ]
    for t in times:
        tmins.append( t[0] )
        tmaxs.append( t[-1] )

    minT, maxT = np.mean(tmins), np.mean(tmaxs)
    newTVec = np.linspace( minT, maxT, len(allBlinks[-1]) )

    allLens = [ len(x) for x in allBlinks ]
    minL = min( allLens )

    img, probeImg = [ ], [ ]
    alignedData, alignedProbeData = [ ], [ ]
    for i, (tvec, yvec) in enumerate(zip(times, allBlinks)):
        row = np.interp( newTVec, tvec, yvec )
        if i in probeTrial:
            probeImg.append( row )
        else:
            img.append( row )
        alignedData.append( zip(newTVec,row) )

    # Separate probe trials.
    probeData, otherData = [ ], [ ]
    for i, row in enumerate( alignedData ):
        if i in probeTrial:
            probeData.append( row )
        else:
            otherData.append( row )

    numTicks = 10
    stepSize = int(len(newTVec) / numTicks)
    xlabels = [ '%d' % int(1000 * x) for x in newTVec[::stepSize] ]

    #plt.figure( figsize=(8,5) )
    ax1 = plt.subplot( 221 )
    plt.imshow( img, interpolation = 'none', aspect = 'auto' )
    plt.title( 'CS+' )
    ticks, labels = computeXTicks( newTVec, tstep = 200 )
    plt.xticks( ticks, [ '%d' % x for x in labels] )
    plt.colorbar( )
    plt.xlabel( 'Time (ms)' )

    # Collect for final summary.
    summaryData = { }
    
    meanOfTrials = np.mean( img, axis = 0 )
    stdOfTrials = np.std( img, axis = 0 )
    summaryData[ 'CS+' ] = ( meanOfTrials, stdOfTrials )

    ax3 = plt.subplot( 223, sharex = ax1 )
    idx = range( len( meanOfTrials ) )
    plt.plot( idx, meanOfTrials, color = 'blue', label = 'CS+' ) 
    plt.fill_between( idx, meanOfTrials - stdOfTrials, meanOfTrials + stdOfTrials
            , color = 'blue'
            , alpha = 0.2
            ) 

    ax2 = plt.subplot( 222, sharex = ax1 )
    plt.imshow( probeImg, interpolation = 'none', aspect = 'auto' )
    plt.title( 'Probe' )
    plt.colorbar( )
    plt.xlabel( 'Time (ms)' )


    # Compute performance index.
    perfs = compute_performance( alignedData )
    pI, piList = compute_performance_index( perfs )

    ax3 = plt.subplot( 223, sharex = ax1 )
    meanOfProbeTrials = np.mean( probeImg, axis = 0 )
    stdOfProbeTrials = np.std( probeImg, axis = 0 )
    idx = range( len( meanOfProbeTrials ) )
    plt.plot( idx, meanOfProbeTrials, color = 'red', label = 'Probe' ) 
    plt.fill_between( idx, meanOfProbeTrials - stdOfProbeTrials
            , meanOfProbeTrials + stdOfProbeTrials
            , color = 'red'
            , alpha = 0.2
            ) 
    ax3.legend( framealpha = 0.1 )
    summaryData[ 'Probe' ] = ( meanOfProbeTrials, stdOfProbeTrials )
    plt.xlabel( 'Time (ms)' )

    # Plot the normalized curves
    ax4 = plt.subplot( 224, sharex = ax1 )
    csM, csU = summaryData[ 'CS+' ]
    baseline = np.mean( csM[:20] )
    y = baseline - csM
    normFact = 1.0 / y.max( )
    for l in summaryData:
        ym, yu = summaryData[ l ]
        ym -= baseline
        ym = np.abs( ym )
        ym *= normFact
        yerr = yu * normFact
        ax4.plot( idx, ym, label = l )
        ax4.legend( framealpha = 0.1 )
        plt.fill_between( idx, ym - yerr, ym + yerr, alpha = 0.2) 

        # Mark CS and PUFF areas
        x1, x2 = tick_for_label( 0, labels, ticks ), tick_for_label( 50, labels, ticks)
        x3, x4 = tick_for_label( 300, labels, ticks ), tick_for_label( 350, labels, ticks)
        ax4.plot( [ x1, x2 ], [ -0.2,-0.2 ] , color = 'black')
        ax4.text( x1, -0.35, 'CS' )
        ax4.plot( [ x3, x4 ], [ -0.2,-0.2 ] , color = 'black')
        ax4.set_ylim( ymin = -0.5, ymax = 1.5 )
        ax4.set_xlim( xmin = tick_for_label( -200, labels, ticks ) )
        ax4.set_yticks( [0, 0.5, 1.0], [0, 0.5, 1.0 ] )
        ax4.text( x3, -0.35, 'PUFF' )
        ax4.set_xlabel( 'Time (ms)' )

    ax4.set_title( 'FEC' )


    outfile = os.path.join( resdir, 'summary.png' )
    plt.tight_layout( pad = 4 )
    trialName = list( filter(None, trialdir.split( '/' )))[-1] 
    plt.xlabel( 'Time (ms)' )

    plt.suptitle( r'Trial: %s' % trialName, x = 0.1)
    plt.savefig( outfile )
    print( 'Wrote summary to %s' % outfile )

def compute_performance_index( perfs ):
    yesOrNoList = [ ]
    yesTrial = 0.0
    for p in perfs:
        if p[0] > config.thres_:
            yesOrNoList.append( True )
            yesTrial += 1.0
        else:
            yesOrNoList.append( False )
    return yesTrial / len(yesOrNoList), yesOrNoList


def compute_baseline( d ):
    baseline = filter( lambda x : x[0] < 0 and x[0] > -0.200, d )
    signal = list( map( lambda x: x[1], baseline ) )
    return np.mean( signal ), np.std( signal )

def compute_learning( d, baseline ):
    tsignal = filter( lambda x : x[0] > 0.0 and x[0] < 0.300, d )
    # Subtract mean of baseline i.e. baseline.
    signal = list( map( lambda x: abs(x[1] - baseline[0]), tsignal ) )
    # Return mean and std of signal and variance of baseline.
    if len( signal ) == 0:
        return 0, 0, baseline
    return max( signal ), np.std( signal ), baseline[1]

def compute_performance( data ):
    learnings = [ ]
    for d in data:
        baseline = compute_baseline( d )
        learning = compute_learning( d, baseline )
        learnings.append( learning )
    return learnings

def main( ):
    datadir = sys.argv[1]
    print( '[INFO] Processing %s' % datadir )
    process( datadir )


if __name__ == '__main__':
    main()
