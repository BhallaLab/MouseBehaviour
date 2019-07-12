"""plot_trial.py: 

"""
    
__author__           = "Dilawar Singh"
__copyright__        = "Copyright 2017-, Dilawar Singh"
__version__          = "1.0.0"
__maintainer__       = "Dilawar Singh"
__email__            = "dilawars@ncbs.res.in"
__status__           = "Development"

import matplotlib as mpl
import matplotlib.pyplot as plt
mpl.style.use( ['bmh'] )
import pandas as pd
from pandas.plotting import register_matplotlib_converters
register_matplotlib_converters()
import sys
import io

cols = ['tcam', 'tarduino'
        , 'millis', 'proto_code', 'trial_count'
        , 'puff', 'tone', 'led'
        , 'camera', 'microscope', 'state'
        , 'shock', 'encoder_val', 'speed'
        , 'blink']

def reformat(df):
    global cols
    df['millis'] = df['millis'].astype(float)
    df['tcam'] -= df['tcam'].iloc[0]
    df['tarduino'] -= df['tarduino'].iloc[0]
    df['millis'] -= df['millis'].iloc[0]
    for x in ['shock', 'encoder_val', 'speed', 'blink']:
        df[x] = df[x].astype(float)

    # In ms units.
    for t in ['tcam', 'tarduino']:
        df[t] = df[t].astype(int)/1e6
    return df

def draw_profile_img(df):
    plt.figure( figsize=(8,5) )
    gridSize = (2, 2)
    ax11 = plt.subplot2grid( gridSize, (0,0), colspan = 1 )
    ax12 = plt.subplot2grid( gridSize, (0,1), colspan = 1 )
    ax21 = plt.subplot2grid( gridSize, (1,0), colspan = 1 )
    
    # plot tcam events and tarduino events.
    tcam = df['tcam']
    tarduino = df['tarduino']
    tArduinoMillis = df['millis']
    tArduinoMillis -= tArduinoMillis[0]
    ax11.scatter(tcam, tArduinoMillis, label='tCam vs tArd1', alpha=0.2)
    ax11.scatter(tcam, tarduino, label='tCam vs tArd2', alpha=0.2)
    ax11.plot([0,0], [3,3], color='black', alpha=0.5, label='slope=1')
    ax11.legend()
    ax11.set_xlabel('Timestamp Cam')
    ax11.set_ylabel('Timestamp Arduino')
    ax11.set_title('A')
    ax12.hist(tcam-tarduino, bins=20)
    ax12.set_xlabel( 'Time (ms)')
    ax12.set_title( 'B. Histogram $t_{CAM} - t_{Arduino}$')

    ax21.hist(tarduino-tArduinoMillis, bins=20)
    ax21.set_xlabel( 'Time (ms)')
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
    return reformat(df)

def plotTrial(data, outfile=None, obj=None):
    df = data2df(data)
    draw_profile_img(df)

    fig = plt.figure()
    gridSize = (3, 2)
    ax1 = plt.subplot2grid( gridSize, (0,0), colspan = 2 )
    ax2 = plt.subplot2grid( gridSize, (1,0), colspan = 2, sharex=ax1)
    ax3 = plt.subplot2grid( gridSize, (2,0), colspan = 2, sharex=ax1)

    ax1.plot(df['tcam'], df['blink'], color='blue', label="Blink")
    ax1.legend()
    ax2.plot(df['tarduino'], df['shock'], color='red', label="Shock")
    ax2.legend()
    ax3.plot(df['tarduino'], df['speed'], label='Speed')

    ax3.set_xlabel('Time (ms)')


    plt.plot([1], [2])
    plt.tight_layout()
    if outfile is None:
        plt.show()
    else:
        plt.savefig(outfile)
    return fig

def test():
    import read_tiff
    _, data = read_tiff.readTiff(sys.argv[1])
    plotTrial(data, 'trial.png')

def main():
    test()

if __name__ == '__main__':
    main()
