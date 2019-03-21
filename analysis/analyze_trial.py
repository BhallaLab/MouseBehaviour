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
from collections import defaultdict
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
    if not os.path.exists(resdir):
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

    # Ploting using trial type.
    groups = defaultdict(list)
    for f, res in trial_data_:
        groups[res.get('trial_type', 'UNKNOWN')].append((f, res))

    for gname in groups.keys():
        print('[INFO] Plotting for %s' % gname)
        ext = gname.replace(' ', '_')
        outfile = os.path.join(resdir, 'summary_%s.png' % ext)
        data = groups[gname]
        plot_trial_data(data, resdir, outfile)

def normalize(mat):
    mat = np.array(mat)
    baseline = np.mean(mat[:30])
    mat = mat - baseline
    mat = mat / mat.max()
    return mat


def plot_trial_data(trial_data_, trialdir, outfile):
    times, allBlinks, probeTrial = [], [], []
    for i, (f, d) in enumerate(trial_data_):
        tvec = d['time']
        cs = d['cs']
        trialType = d.get('trial_type', 'UNKNOWN')
        print('[INFO] Trial type is %s' % trialType)
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

    minT, maxT = np.mean(tmins), np.mean(tmaxs)
    newTVec = np.linspace(minT, maxT, len(allBlinks[-1]))

    csImg, img, probeImg = [], [], []
    alignedData = []

    for i, (tvec, yvec) in enumerate(zip(times, allBlinks)):
        row = np.interp(newTVec, tvec, yvec)
        img.append(row)
        if i in probeTrial:
            probeImg.append(row)
        else:
            csImg.append(row)
        alignedData.append(zip(newTVec, row))

    #  img = normalize(img)
    #  probeImg = normalize(probeImg)

    print('No of probe trials : %d' % len(probeImg))
    print('No of other trials: %s' % len(img))
    plt.figure(figsize=(12,8))
    ax1 = plt.subplot(221)
    ax1.grid(False)
    im = ax1.imshow(img, interpolation='none', aspect='auto', cmap=cmap_)
    plt.colorbar(im, ax=ax1)
    plt.title('CS+ and PROBE')
    ticks, labels = computeXTicks(newTVec, tstep=200)
    plt.xticks(ticks, ['%d' % x for x in labels])
    plt.xlabel('Time (ms)')

    # Collect for final summary.
    summaryData = {}
    img = normalize(img)
    meanOfTrials = np.mean(img, axis=0)
    stdOfTrials = np.std(img, axis=0)
    summaryData['CS+'] = (meanOfTrials, stdOfTrials)
    ax3 = plt.subplot(223, sharex=ax1)
    idx = range(len(meanOfTrials))
    plt.plot(idx, meanOfTrials, color='blue', label='CS+')
    plt.fill_between(
            idx, meanOfTrials - stdOfTrials, meanOfTrials + stdOfTrials, color='blue', alpha=0.2
            )

    ax2 = plt.subplot(222, sharex=ax1)
    ax2.grid(False)
    if len(probeImg) > 0:
        print("[INFO ] Plotting PROBE trials.")
        im = ax2.imshow(probeImg, interpolation='none',
                        aspect='auto', cmap=cmap_)
        ax2.set_title('PROBE')
        plt.colorbar(im, ax=ax2)
        ax2.set_xlabel('Time (ms)')

    # Compute performance index.
    perfs = compute_performance(alignedData)
    pI, piList = compute_performance_index(perfs)

    ax3 = plt.subplot(223, sharex=ax1)
    if len(probeImg) > 0:
        probeImg = normalize(probeImg)
        meanOfProbeTrials = np.mean(probeImg, axis=0)
        stdOfProbeTrials = np.std(probeImg, axis=0)
        idx = range(len(meanOfProbeTrials))
        ax3.plot(idx, meanOfProbeTrials, color='red', label='Probe')
        ax3.fill_between(idx, meanOfProbeTrials - stdOfProbeTrials
                , meanOfProbeTrials + stdOfProbeTrials, color='red', alpha=0.2
                )
        ax3.legend(framealpha=0.1)
        summaryData['Probe'] = (meanOfProbeTrials, stdOfProbeTrials)
        plt.xlabel('Time (ms)')

    # Plot the normalized curves
    ax4 = plt.subplot(224, sharex=ax1)
    csM, csU = summaryData['CS+']
    baseline = np.mean(csM[:20])
    y = csM - baseline
    normFact = 1.0 / y.max()
    for l, c in zip(summaryData, ['blue', 'red']):
        ym, yerr = summaryData[l]
        baseline = np.mean(ym[:20])
        ym -= baseline
        ax4.plot(idx, ym, label=l, color=c, alpha=0.8)
        ax4.legend(framealpha=0.1)
        ax4.fill_between(idx, ym - yerr, ym + yerr, color=c, alpha=0.1)

        # Mark CS and PUFF areas
        x1, x2 = tick_for_label(
            0, labels, ticks), tick_for_label(50, labels, ticks)
        x3, x4 = tick_for_label(
            300, labels, ticks), tick_for_label(350, labels, ticks)
        ax4.plot([x1, x2], [-0.2, -0.2], color='black')
        ax4.text(x1, -0.35, 'CS', fontsize=10)
        ax4.set_xlim(xmin = tick_for_label( -200, labels, ticks ) )
        ax4.set_yticks([0, 0.5, 1.0], [0, 0.5, 1.0])
        ax4.text(x3, -0.35, 'PUFF', fontsize=10)
        ax4.set_xlabel('Time (ms)')

    ax4.plot([x3, x4], [-0.2, -0.2], color='black')
    ax4.set_title('FEC')

    trialName = list(filter(None, trialdir.split('/')))[-1]
    ax4.set_xlabel('Time (ms)')
    #  plt.suptitle(r'Trial: %s' % trialName, x=0.1)
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


def compute_baseline(d):
    baseline = filter(lambda x: x[0] < 0 and x[0] > -0.200, d)
    signal = list(map(lambda x: x[1], baseline))
    return np.mean(signal), np.std(signal)


def compute_learning(d, baseline):
    tsignal = filter(lambda x: x[0] > 0.0 and x[0] < 0.300, d)
    # Subtract mean of baseline i.e. baseline.
    signal = list(map(lambda x: abs(x[1] - baseline[0]), tsignal))
    # Return mean and std of signal and variance of baseline.
    if len(signal) == 0:
        return 0, 0, baseline
    return max(signal), np.std(signal), baseline[1]


def compute_performance(data):
    learnings = []
    for d in data:
        baseline = compute_baseline(d)
        learning = compute_learning(d, baseline)
        learnings.append(learning)
    return learnings


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
