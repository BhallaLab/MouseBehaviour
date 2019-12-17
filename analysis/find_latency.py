#!/usr/bin/env python3

import sys
import os
import numpy as np
import matplotlib as mpl
mpl.use('TkAgg')
import matplotlib.pyplot as plt
import pandas as pd
pd.plotting.register_matplotlib_converters()

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
    ax2.set_xlabel('Time (ms)')
    ax2.set_ylabel('Time (ms)')
    ax2.legend()

    ax3.hist(t0-t1, alpha=0.5, density=True, label='tCam-tArdReceived')
    ax3.hist(t1-t2, alpha=0.5, density=True, label='tArdReceived-tArd')
    ax3.legend()
    ax3.set_xlabel('Time (ms)')

    plt.tight_layout()
    plt.savefig(f'{outfilePrefix}.png')

    ref = pd.DataFrame()
    ref['tcam'] = t0
    ref['tArdReceived'] = t1
    ref['tArd'] = t2
    ref.to_csv(f'{outfilePrefix}.csv', index=False)


if __name__ == '__main__':
    main()
