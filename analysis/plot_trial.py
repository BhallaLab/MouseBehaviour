import matplotlib as mpl
import pandas as pd
import matplotlib.pyplot as plt
import sys
import datetime
import time
import numpy as np
import io

cols = ['tcam', 'tarduino', 'tms', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'blink']

def profile_img(df):
    fig = plt.figure()
    gridSize = (3, 2)
    ax1 = plt.subplot2grid( gridSize, (0,0), colspan = 2 )
    ax2 = plt.subplot2grid( gridSize, (1,0), colspan = 2 )
    ax3 = plt.subplot2grid( gridSize, (2,0), colspan = 1 )
    ax4 = plt.subplot2grid( gridSize, (2,1), colspan = 1 )
    
    # plot tcam events and tarduino events.
    x = df['tcam']
    print( x)
    ax1.scatter(x, [1]*len(x))

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
    return df

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
