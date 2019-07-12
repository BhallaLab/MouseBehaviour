import pandas as pd
from pandas.plotting import register_matplotlib_converters
register_matplotlib_converters()
import matplotlib.pyplot as plt
import sys
import datetime
import time
import numpy as np
import io

cols = ['tcam', 'tarduino', 'tms', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'blink']

def stampToSec(tvec):
    start = tvec[0]
    tvec -= start
    return start, tvec.astype(int)/1e9

def profile_img(df):
    plt.figure( figsize=(8,5) )
    gridSize = (2, 2)
    ax11 = plt.subplot2grid( gridSize, (0,0), colspan = 1 )
    ax12 = plt.subplot2grid( gridSize, (0,1), colspan = 1 )
    ax21 = plt.subplot2grid( gridSize, (1,0), colspan = 1 )
    
    # plot tcam events and tarduino events.
    tcamStart, tcam = stampToSec(df['tcam'])
    tarduinoStart, tarduino = stampToSec(df['tarduino'])
    tArduinoMillis = df['tms'].astype(int)/1e3
    tArduinoMillis -= tArduinoMillis[0]
    ax11.scatter(tcam, tArduinoMillis, label='tCam vs tArd1', alpha=0.2)
    ax11.scatter(tcam, tarduino, label='tCam vs tArd2', alpha=0.1)
    ax11.plot([0,0], [3,3], color='black', alpha=0.5, label='slope=1')
    ax11.legend()
    ax11.set_xlabel('Timestamp Cam')
    ax11.set_ylabel('Timestamp Arduino')
    ax11.set_title('A')
    ax12.hist(tcam-tarduino, bins=20)
    ax12.set_xlabel( 'Time (sec)')
    ax12.set_title( 'B. Histogram $t_{CAM} - t_{Arduino}$')

    ax21.hist(tarduino-tArduinoMillis, bins=20)
    ax21.set_xlabel( 'Time (sec)')
    ax21.set_title( 'C. Histogram $t_{Arduino} - t_{ArduinoMillis}$')

    #  fig.autofmt_xdate()
    plt.tight_layout()
    plt.savefig( 'profile.png')
    plt.close()


def data2df(data):
    global cols
    withArduino, withoutArduino  = [], []
    for l in data:
        l = l.strip()
        if not l:
            continue
        fs = l.split(',')
        if len(fs) == 2:
            withoutArduino.append(l)
        else:
            withArduino.append(l)
    txtA, txtB = '\n'.join(withArduino), '\n'.join(withoutArduino)
    A = pd.read_csv(io.StringIO(txtA), names=cols, parse_dates=[0,1,2])
    B = pd.read_csv(io.StringIO(txtB), names=[cols[0], cols[-1]], parse_dates=[0])

    # merge both df and sort by tcam.
    df = pd.concat([A, B], axis=0, ignore_index=True, names=cols, sort=True)
    df.sort_values(by=['tcam'], inplace=True)
    return A

def plotTrial(data, obj=None):
    df = data2df(data)
    profile_img(df)
    quit()
    fig = plt.figure()
    plt.plot([1], [2])
    plt.tight_layout()
    plt.show()
    return fig

def test():
    import read_tiff
    _, data = read_tiff.readTiff(sys.argv[1])
    plotTrial(data)

def main():
    test()

if __name__ == '__main__':
    main()
