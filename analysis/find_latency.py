#!/usr/bin/env python3

import sys
import os
import numpy as np
import matplotlib as mpl
mpl.use('TkAgg')
import matplotlib.pyplot as plt
import pandas as pd
import scipy.optimize as sco
pd.plotting.register_matplotlib_converters()

def fit_linear(x, m, c):
    return m*x+c

def main():
    infile = sys.argv[1]
    outfilePrefix = os.path.basename(infile) + '.latency'

    df = pd.read_csv(infile, usecols=[0,1,2], parse_dates=[0,1]
            , names=['t0', 't1', 't2'])

    t0, t1, t2 = df['t0'].values, df['t1'].values, df['t2']
    t0 = t0.astype(np.float)    # ms
    t0 = t0 - t0[0]
    t1 = t1 - t1[0]
    t2 = t2 - t2[0]
    t0 = t0.astype(np.float)/1e6    # ms
    t1 = t1.astype(np.float)/1e6    # ms


    plt.figure(figsize=(12,3))
    ax1 = plt.subplot(131)
    ax2 = plt.subplot(132)
    ax3 = plt.subplot(133)

    ax1.plot(t0, t1, label='tArdReceived')
    ax1.plot(t0, t2, label='tArd')
    ax1.legend()
    ax1.set_ylabel('Time (ms)')
    ax1.set_xlabel('Time (ms)')

    ax2.plot(t0, t0 - t1, label='tCam-tArd')
    #  ax2.plot(t0, t0 - t1, label='tCam-tArdReceived')
    ax2.plot(t0, t1 - t2, label='tArdReceived-tArd')

    # fit
    y = t1-t2
    (m, c), _ = sco.curve_fit(fit_linear, t0, y)
    tJitter = y - fit_linear(t0, m, c)
    ax2.plot(t0, fit_linear(t0, m, c), label=f'Fit $y={m:g}x+{c:g}$')

    ax2.set_xlabel('Time (ms)')
    ax2.set_ylabel('Time (ms)')
    ax2.legend()

    ax3.hist(t0-t1, alpha=0.5, density=True, label='tCam-tArdReceived')
    ax3.hist(tJitter, alpha=0.5, density=True, label='tArdReceived-tArd')
    ax3.legend()
    ax3.set_xlabel('Time (ms)')

    plt.tight_layout()
    plt.savefig(f'{outfilePrefix}.png')

    ref = pd.DataFrame()
    ref['tcam'] = t0
    ref['tArdReceived'] = t1
    ref['tArd'] = t2
    ref['tDiffJitter'] = tJitter
    ref.to_csv(f'{outfilePrefix}.csv', index=False)


if __name__ == '__main__':
    main()
