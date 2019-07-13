# Methods.
__author__ = "Dilawar Singh"
__copyright__ = "Copyright 2017-, Dilawar Singh"
__version__ = "1.0.0"
__maintainer__ = "Dilawar Singh"
__email__ = "dilawars@ncbs.res.in"
__status__ = "Development"

import matplotlib as mpl
import matplotlib.pyplot as plt
try:
    mpl.style.use( ['bmh', 'fivethirtyeight'] )
except Exception:
    pass
import pandas as pd
pd.plotting.register_matplotlib_converters()
import sys
import io
from pathlib import Path
from PIL import Image
import numpy as np

cols = [
    'tcam', 'tarduino', 'millis', 'proto_code', 'trial_count', 'puff', 'tone',
    'led', 'camera', 'microscope', 'state', 'shock', 'encoder_val', 'speed',
    'blink'
]


def readTiff(filepath):
    img = Image.open(filepath)
    data, frames = [], []
    for i in range(img.n_frames):
        img.seek(i)
        f = np.array(img)
        frames.append(f)
        line = [chr(x) for x in f[0, :]]
        data.append(''.join(line))
    return frames, data


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
        df[t] = df[t].astype(int) / 1e6
    return df


def draw_profile_img(df, outfile='profile.png'):
    plt.figure(figsize=(8, 5))
    gridSize = (2, 2)
    ax11 = plt.subplot2grid(gridSize, (0, 0), colspan=1)
    ax12 = plt.subplot2grid(gridSize, (0, 1), colspan=1)
    ax21 = plt.subplot2grid(gridSize, (1, 0), colspan=1)

    # plot tcam events and tarduino events.
    tcam = df['tcam']
    tarduino = df['tarduino']
    tArduinoMillis = df['millis']
    tArduinoMillis -= tArduinoMillis[0]
    ax11.scatter(tcam, tArduinoMillis, label='tCam vs tArd1', alpha=0.2)
    ax11.scatter(tcam, tarduino, label='tCam vs tArd2', alpha=0.2)
    ax11.plot([0, 0], [3, 3], color='black', alpha=0.5, label='slope=1')
    ax11.legend()
    ax11.set_xlabel('Timestamp Cam')
    ax11.set_ylabel('Timestamp Arduino')
    ax11.set_title('A')
    ax12.hist(tcam - tarduino, bins=20)
    ax12.set_xlabel('Time (ms)')
    ax12.set_title('B. Histogram $t_{CAM} - t_{Arduino}$')

    ax21.hist(tarduino - tArduinoMillis, bins=20)
    ax21.set_xlabel('Time (ms)')
    ax21.set_title('C. Histogram $t_{Arduino} - t_{ArduinoMillis}$')

    #  fig.autofmt_xdate()
    plt.tight_layout()
    plt.savefig(outfile)
    plt.close()


def data2df(data):
    global cols
    withArduino, withoutArduino = [], []
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
    A = pd.read_csv(io.StringIO(txtA), names=cols, parse_dates=[0, 1, 2])
    B = pd.read_csv(io.StringIO(txtB),
                    names=[cols[0], cols[-1]],
                    parse_dates=[0])

    # merge both df and sort by tcam.
    df = pd.concat([A, B], axis=0, ignore_index=True, names=cols, sort=True)
    df.sort_values(by=['tcam'], inplace=True)
    return reformat(df)


def plotAndSaveData(data, outfile, obj=None):
    df = data2df(data)
    h5file = f"{outfile}.h5"
    df.to_hdf(h5file, key="session_data")
    draw_profile_img(df, f"{outfile}.profile.png")
    plt.figure()
    gridSize = (3, 2)
    ax1 = plt.subplot2grid(gridSize, (0, 0), colspan=2)
    ax2 = plt.subplot2grid(gridSize, (1, 0), colspan=2, sharex=ax1)
    ax3 = plt.subplot2grid(gridSize, (2, 0), colspan=2, sharex=ax1)

    ax1.plot(df['tcam'], df['blink'], color='blue', label="Blink")
    ax1.legend()
    ax2.plot(df['tarduino'], df['shock'], color='red', label="Shock")
    ax2.legend()
    ax3.plot(df['tarduino'], df['speed'], label='Speed')
    ax3.legend()
    ax3.set_xlabel('Time (ms)')
    plt.tight_layout()
    plt.savefig(outfile)
    plt.close()
    return Path(h5file), Path(outfile)


def getTrialNumber(path: str):
    return int(path.split('.')[0])


def interpolate_uniform(x0, y0, x1):
    # given x0, y0, return x1, y1.
    return np.interp(x1, x0, y0)

def showImage(ax, xyz, what='', X=None, Y=None, **kwargs):
    X, Y, Z = xyz
    im = ax.imshow(Z, interpolation='none', aspect='auto')
    return im
    #  im = ax.pcolormesh(X, Y, Z)
    #  plt.colorbar(im, ax=ax)
    #  ax.set_xlabel(kwargs.get('xlabel', 'Time (ms)'))
    #  ax.set_ylabel(kwargs.get('ylabel', r'#Trial'))
    #  ax.set_title(kwargs.get('title', what))

def setXTickLabels(ax, labels, every=10):
    indices = range(len(labels))
    ax.set_xticks(indices[::every])
    ax.set_xticklabels(map(int, labels[::every]))

def setYTickLabels(ax, labels, every=3):
    indices = range(len(labels))
    ax.set_yticks(indices[::every])
    ax.set_yticklabels(labels[::every])


def plotOnAxis(df, ax, what, probeax=None, **kwargs):
    ax.grid(False)
    if probeax is None:
        probeax.grid(False)
    trials = df.index.levels[0]
    # evenly spaced 5ms time.
    newT = np.arange(df['tcam'].min(), df['tcam'].max(), 1)
    X, Y, Z, XProbe, YProbe, ZProbe = [], [], [], [], [], []
    for trialNum in trials:
        tdf = df.loc[trialNum]
        x, y = tdf['tcam'].values, tdf[what].values
        newY = interpolate_uniform(x, y, newT)
        if 'PROB' in set(tdf['state']):
            print( f"[INFO ] PROBE type found {trialNum}" )
            XProbe.append(newT)
            YProbe.append(trialNum)
            ZProbe.append(newY)
        else:
            X.append(newT)
            Y.append(trialNum)
            Z.append(newY)

    # non-probe axis
    im = showImage(ax, (X, Y, Z), what, newT, trials, **kwargs)
    plt.colorbar(im, ax=ax)
    ax.set_title(what)
    ax.set_ylabel(r'# Trial')
    ax.set_xticks([])
    setYTickLabels(ax, Y, every=4)

    # Probe trials.
    im = showImage(probeax, (XProbe, YProbe, ZProbe), '', **kwargs)
    cb = plt.colorbar(im, ax=probeax)
    #  cb.remove()
    probeax.set_ylabel(r'# Probe')
    setYTickLabels(probeax, YProbe, every=2)
    setXTickLabels(probeax, newT, every=500)

def plotSession(df):
    plt.figure(figsize=(15, 10))
    gridSize = (20, 2)
    ax111 = plt.subplot2grid(gridSize, (0, 0), colspan=1, rowspan=8)
    ax112 = plt.subplot2grid(gridSize, (8, 0), colspan=1, rowspan=2)
    ax121 = plt.subplot2grid(gridSize, (0, 1), colspan=1, rowspan=8)
    ax122 = plt.subplot2grid(gridSize, (8, 1), colspan=1, rowspan=2)

    ax3 = plt.subplot2grid(gridSize, (10, 0), colspan=1, rowspan=10)
    ax4 = plt.subplot2grid(gridSize, (10, 1), colspan=1, rowspan=10)
    plt.subplots_adjust(hspace=5)

    plotOnAxis(df, ax111, 'blink', probeax=ax112)
    plotOnAxis(df, ax121, 'shock', probeax=ax122)

    plt.savefig('session.png')
    plt.close()


def postProcessDir(path):
    assert path.is_dir()
    m = {getTrialNumber(x.name) : pd.read_hdf(x) for x in path.glob("*.h5")}
    res = pd.concat(m.values(), keys=m.keys())
    plotSession(res)

def test(path):
    _, data = readTiff(path)
    plotAndSaveData(data, 'trial.png')


def test_dir(path):
    postProcessDir(path)


def main():
    p = Path(sys.argv[1])
    if p.is_file():
        test(p)
    elif p.is_dir():
        test_dir(p)
    else:
        raise RuntimeError(f"Invalid path {p}")


if __name__ == '__main__':
    main()
