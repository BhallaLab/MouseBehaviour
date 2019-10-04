#!/usr/bin/env python3

__author__ = "Dilawar Singh"
__copyright__ = "Copyright 2016, Dilawar Singh "
__credits__ = ["NCBS Bangalore"]
__license__ = "GNU GPL"
__version__ = "1.0.0"
__maintainer__ = "Dilawar Singh"
__email__ = "dilawars@ncbs.res.in"
__status__ = "Development"

import os
import analyze_trial_video
import pickle
import numpy as np
import config
import multiprocessing
import scipy.interpolate as sci
import matplotlib as mpl
import matplotlib.pyplot as plt
try:
    #  mpl.style.use(['bmh', 'fivethirtyeight'])
    mpl.style.use(['bmh'])
except Exception as e:
    pass

trial_data_ = []
kwargs_ = {}
cmap_ = 'jet'


def tick_for_label(label, labels, ticks):
    return np.interp(label, labels, ticks)

def computeXTicks(time, tstep=100):
    """
    Put a tick at 100ms
    """
    time = 1000 * time
    xticks = np.arange(0, len(time), 1)
    nticks = int((time.max() - time.min()) / tstep)
    step = int(len(time) / nticks)
    xticks = xticks[::step]
    labels = time[::step]
    newrange = np.int32([time.min() / 100.0, time.max() / 100.0]) * 100.0
    newlabels = np.arange(newrange[0], newrange[1], tstep)
    newIndex = np.rint(np.interp(newlabels, labels, xticks))
    return newIndex, newlabels

def process_file(f):
    global kwargs_
    resdir = kwargs_['outdir']
    pickleFile = os.path.join(resdir, os.path.basename('%s.pickle' % f))
    if not os.path.exists(pickleFile):
        kwargs_['input'] = f
        analyze_trial_video.process(**kwargs_)
    else:
        print('[INFO] Pickle file already exists.')

def generate_pickels(tiffs, resdir):
    global kwargs_
    p = multiprocessing.Pool(2)
    p.map(process_file, sorted(tiffs))

def process(**kwargs):
    global trial_data_
    datadir = kwargs['datadir']
    print('[INFO] Processing %s' % datadir)
    resdir = kwargs.get('outdir', os.path.join(datadir, config.tempdir))
    if resdir and not os.path.exists(resdir):
        os.makedirs(resdir)
    tiffs = []
    for d, sd, fs in os.walk(datadir):
        for f in fs:
            ext = f.split('.')[-1]
            if ext in ['tiff', 'tif']:
                tiffs.append(os.path.join(d, f))

    assert len(tiffs)>0, "No tiff file found"
    generate_pickels(tiffs, resdir)
    for f in sorted(tiffs):
        pickleFile = os.path.join(resdir, os.path.basename('%s.pickle' % f))
        if os.path.exists(pickleFile):
            print('[INFO] Pickle file is found. Reusing it')
            with open(pickleFile, 'rb') as pF:
                res = pickle.load(pF)
                trial_data_.append((f, res))

    # Plot all data together.
    outfile = os.path.join(resdir, 'summary.png')
    plot_trial_data(trial_data_, datadir, outfile)

def normalize(mat, offset, scale):
    # Normalize the data.
    mat = mat - offset 
    mat /= scale
    return mat
    

def plot_trial_data(trial_data_, trialdir, outfile):
    times, allBlinks, probeTrial = [], [], []
    for i, (f, d) in enumerate(trial_data_):
        tvec = d['time']
        cs = d['cs']
        tvec = list(map(lambda x: (x - cs[0]).total_seconds(), tvec))
        duration = 1000 * (tvec[-1] - tvec[0])
        if duration < 900:
            print('[WARN] %s was shorter than 900 ms. Duration %d' %
                  (f, duration))
        times.append(tvec)
        allBlinks.append(d['blinks'])
        if d['is_probe'] == True:
            probeTrial.append(i)

    tmins, tmaxs = [], []
    for t in times:
        tmins.append(t[0])
        tmaxs.append(t[-1])

    minT, maxT = np.max(tmins), np.min(tmaxs)
    newTVec = np.linspace(minT, maxT, 300)

    csImg, img, probeImg = [], [], []
    alignedData = []
    for i, (tvec, yvec) in enumerate(zip(times, allBlinks)):
        row = sci.interp1d(tvec, yvec, kind='cubic')(newTVec)
        alignedData.append(row)
        if i in probeTrial:
            probeImg.append(row)
        else:
            csImg.append(row)

    alignedData = np.array(alignedData)
    baseLineIndex = np.where((newTVec>0.05) & (newTVec<0.2))[0]
    blData = alignedData[:,baseLineIndex]
    blMean, blStd = np.mean(blData), np.std(blData)
    # Similarly between 500 to 800 is our lage signal.
    blinkIndex = np.where((newTVec>0.5)&(newTVec<0.7))
    blinkData = alignedData[:,blinkIndex]
    blinkMean, blinkStd = np.mean(np.max(blinkData, axis=2)), np.std(blinkData)
    print("[INFO ] Baseline: Mean %.3f +/- %.3f" % (blMean, blStd))
    print("[INFO ] Blink: Mean %.3f +/- %.3f" % (blinkMean, blinkStd))

    # Normalize the data.
    normOffset = blMean - blStd
    normScale = blinkMean - normOffset
    alignedData = normalize(alignedData, normOffset, normScale)
    
    print('No of probe trials : %d' % len(probeImg))
    print('No of other trials: %s' % len(img))
    plt.figure(figsize=(12,5))
    ax1 = plt.subplot(121)
    ax1.set_ylabel('# Trial')
    ax1.grid(False)
    im = ax1.imshow(alignedData, interpolation='none', aspect='auto', cmap=cmap_)
    cbar = plt.colorbar(im, ax=ax1)
    cbar.set_ticks([0, 1])
    cbar.set_ticklabels(['Open', 'Close'])
    cbar.update_ticks()
    plt.title('CS+ and PROBE')
    ticks, labels = computeXTicks(newTVec, tstep=200)
    plt.xticks(ticks, ['%d'%x for x in labels])
    plt.xlabel('Time (ms)')

    ## Collect for final summary.
    ax2 = plt.subplot(122)
    csMat, probeMat = np.array(csImg), np.array(probeImg)
    csMat = normalize(csMat, normOffset, normScale)
    probeMat = normalize(probeMat, normOffset, normScale)
    for mat, c, label in zip((csMat,probeMat), ('blue','red'), ('CS+','PROBE')):
        Y = np.mean(mat, axis=0)
        Yerr = np.std(mat, axis=0)
        ax2.plot(1000*newTVec, Y, color=c, label=label)
        ax2.fill_between(1000*newTVec, Y-Yerr, Y+Yerr, color=c, alpha=0.2)
        plt.legend(loc='best', framealpha=0.4)
    plt.tight_layout(pad=2)
    plt.savefig(outfile)
    plt.close()
    print('Wrote summary to %s' % outfile)

def compute_performance_index(perfs):
    yesOrNoList = []
    yesTrial = 0.0
    for p in perfs:
        if p[0] > config.thres_:
            yesOrNoList.append(True)
            yesTrial += 1.0
        else:
            yesOrNoList.append(False)
    return yesTrial / len(yesOrNoList), yesOrNoList

def compute_baseline(T, Y):
    # x[0] is time. Upto 200ms
    signal = [ y for (t, y) in zip(T, Y) if (t> 0.050 and t < 0.200)]
    return np.mean(signal), np.std(signal)

def main(**kwargs):
    global kwargs_
    kwargs_ = kwargs
    process(**kwargs)

if __name__ == '__main__':
    import argparse
    # Argument parser.
    description = '''Analyze trial'''
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('--datadir', '-d'
            , required=True, help='Directory where tiff files are stored.'
            )
    parser.add_argument('--outdir', '-o'
            , required=False, default='', help='Where to store results.'
            )
    parser.add_argument('--classifier', '-c'
            , required=False, default='', help='Classifier to load'
            )
    parser.add_argument('--plot', '-p'
            , default=False, action='store_true', help='Plot while analysing.'
            )
    class Args:
        pass
    args = Args()
    parser.parse_args(namespace=args)
    main(**vars(args))
