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
    mpl.style.use(['bmh', 'fivethirtyeight'])
except Exception:
    pass
import pandas as pd
pd.plotting.register_matplotlib_converters()
import sys
import io
from pathlib import Path
from PIL import Image
import re
import numpy as np
import scipy.interpolate as sci

# Arduino data has variable number of entries. Old data may have less than 15
# fields.
colsDict ={ 
        15: [
            'tcam', 'tarduino', 'millis', 'proto_code', 'trial_count', 'puff', 'tone',
            'led', 'camera', 'microscope', 'state', 'shock', 'encoder_val', 'speed', 'blink'
            ],
        14 : [
            'tcam', 'tarduino', 'millis', 'proto_code', 'trial_count', 'puff', 'tone',
            'led', 'camera', 'microscope', 'state', 'encoder_val', 'speed', 'blink'
            ],
        13: [
            'tcam', 'tarduino', 'millis', 'trial_count', 'puff', 'tone',
            'led', 'camera', 'microscope', 'encoder_value', 'speed', 'state', 'blink'
            ],
        }


def readTiff(filepath):
    img = Image.open(filepath)
    data, frames = [], []
    for i in range(img.n_frames):
        img.seek(i)
        f = np.array(img)
        frames.append(f)
        line = [chr(x) for x in f[0, :]]
        data.append((''.join(line)).strip())
    return frames, data


def reformat(df):
    global cols
    df.dropna(subset=['tarduino', 'tcam'], inplace=True)
    df['millis'] = df['millis'].astype(float)
    df['tcam'] -= df['tcam'].iloc[0]
    df['tarduino'] -= df['tarduino'].iloc[0]
    df['millis'] -= df['millis'].iloc[0]
    for x in ['shock', 'encoder_val', 'speed', 'blink']:
        if x in df.columns:
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
    withArduino, withoutArduino = [], []
    nCols = 0
    for l in data:
        l = l.strip()
        if not l:
            continue
        fs = l.split(',')
        nCols = max(len(fs), nCols)
        if len(fs) == 2:
            withoutArduino.append(l)
        else:
            withArduino.append(l)
    cols = colsDict[nCols]
    txtA, txtB = '\n'.join(withArduino), '\n'.join(withoutArduino)
    A, B = None, None
    try:
        A = pd.read_csv(io.StringIO(txtA), names=cols, parse_dates=[0, 1, 2])
    except Exception as e:
        print( f"[ERROR] Failed to parse {txtA}" )
        print(e, cols)
        quit(1)

    try:
        B = pd.read_csv(io.StringIO(txtB),
                        names=[cols[0], cols[-1]],
                        parse_dates=[0])
    except Exception as e:
        print( f"[ERROR] Failed to parse {txtB}" )
        print(e, cols)
        quit(1)

    # merge both df and sort by tcam.
    df = pd.concat([A, B], axis=0, ignore_index=True, names=cols, sort=False)
    df.sort_values(by=['tcam'], inplace=True)
    return reformat(df)


def plotAndSaveData(data, outfile, obj=None):
    df = data2df(data)
    h5file = f"{outfile}.h5"
    df.to_hdf(h5file, key="session_data")
    try:
        draw_profile_img(df, f"{outfile}.profile.png")
    except Exception as e:
        print( f"[INFO ] Failed to plot profiling. Error was {e}" )
        
    plt.figure()
    gridSize = (3, 2)
    ax1 = plt.subplot2grid(gridSize, (0, 0), colspan=2)
    ax2 = plt.subplot2grid(gridSize, (1, 0), colspan=2, sharex=ax1)
    ax3 = plt.subplot2grid(gridSize, (2, 0), colspan=2, sharex=ax1)

    ax1.plot(df['tcam'], df['blink'], color='blue', label="Blink")
    ax1.legend()
    if 'shock' in df.columns:
        ax2.plot(df['tarduino'], df['shock'], color='red', label="Shock")
        ax2.legend()
    if 'speed' in df.columns:
        ax3.plot(df['tarduino'], df['speed'], label='Speed')
    ax3.legend()
    ax3.set_xlabel('Time (ms)')
    plt.tight_layout()
    plt.savefig(outfile)
    plt.close()
    return Path(h5file), Path(outfile)


def getTrialNumber(path: str) -> int:
    # remove trial_ prefix from path if any. Old data might have it
    m = re.search('\d+', path)
    if m:
        return int(m[0])
    else:
        return -1

def interpolate_uniform(x0, y0, x1):
    # given x0, y0, return x1, y1.
    f = sci.interp1d(x0, y0, kind=1, fill_value='extrapolate')
    return f(x1)


def showImage(ax, xyz, what='', X=None, Y=None, **kwargs):
    X, Y, Z = xyz
    im = ax.imshow(Z, interpolation='none', aspect='auto', cmap='seismic')
    return im


def setXTickLabels(ax, labels, every=10):
    indices = range(len(labels))
    ax.set_xticks(indices[::every])
    ax.set_xticklabels(map(int, labels[::every]))


def setYTickLabels(ax, labels, every=3):
    indices = range(len(labels))
    ax.set_yticks(indices[::every])
    ax.set_yticklabels(labels[::every])


def subtractBaseline(t, y):
    # get the baseline upto first 300ms. Each trial has its own baseline.
    baseline = []
    for t, yy in zip(t, y):
        if t < 300:
            baseline.append(yy)
    baselineM = np.mean(baseline)
    y -= baselineM
    return y

def splitTrialsAndInterpolate(df, what):
    """
    Separate out PROBE trials and normal trials according to what e.g., blink,
    shock etc. Then resample such at each point is 5ms away for each other.
    """
    trials = df.index.levels[0]
    # evenly spaced 5ms time.
    newT = np.arange(df['tcam'].min(), df['tcam'].max(), 5)
    X, Y, Z, XProbe, YProbe, ZProbe = [], [], [], [], [], []
    for trialNum in trials:
        tdf = df.loc[trialNum]
        x, y = tdf['tcam'].values, tdf[what].values
        newY = interpolate_uniform(x, y, newT)
        if 'PROB' in set(tdf['state']):
            print(f"[INFO ] PROBE type found {trialNum}")
            XProbe.append(newT)
            YProbe.append(trialNum)
            ZProbe.append(newY)
        else:
            X.append(newT)
            Y.append(trialNum)
            Z.append(newY)
    return (X, Y, Z), (XProbe, YProbe, ZProbe), trials

def plotOnAxis(df, ax, what, probeAx=None, summaryAx=None, **kwargs):
    ax.grid(False)
    if probeAx is None:
        probeAx.grid(False)

    (X,Y,Z), (Xp,Yp,Zp), trials = splitTrialsAndInterpolate(df, what)
    newT = X[0]

    # non-probe axis
    im = showImage(ax, (X, Y, Z), what, newT, trials, **kwargs)
    plt.colorbar(im, ax=ax)
    ax.set_title(f"{what.upper()}")
    ax.set_ylabel(r'# Trial')
    ax.set_xticks([])
    #setYTickLabels(ax, Y, every=4)

    # Probe trials.
    im = showImage(probeAx, (Xp, Yp, Zp), '', **kwargs)
    cb = plt.colorbar(im, ax=probeAx)
    cb.remove()
    probeAx.set_title(r'Probe Trials', loc='right', fontsize='small')
    #setYTickLabels(probeAx, Yp, every=2)
    setXTickLabels(probeAx, newT, every=100)

    if summaryAx is not None:
        print( f"[INFO ] Plotting summary." )
        zMean, zStd = np.mean(Z, axis=0), np.std(Z, axis=0)
        summaryAx.fill_between(newT, zMean+zStd, zMean-zStd, alpha=0.3)
        summaryAx.plot(newT, zMean, label='Without PROBE')

        zpMean, zpStd = np.mean(Zp, axis=0), np.std(Zp, axis=0)
        summaryAx.fill_between(newT, zpMean+zpStd, zpMean-zpStd, alpha=0.3)
        summaryAx.plot(newT, zpMean, label='Only PROBE')
        summaryAx.legend()

        summaryAx.set_xlabel('Time (ms)')


def normalizeAndBaseline(res):
    # Normalize whole session. 
    for x in ['blink', 'shock']:
        if x in res.columns:
            res[x] -= res[x].min()
            res[x] /= res[x].max()
    #  baseline = res[res['tcam'] < 300]
    return res

def plotSession(df):
    gridSize = (20, 2)

    # plot upto 2500ms
    #  df = df[df['tcam'] < 2500]

    ax111 = plt.subplot2grid(gridSize, (0, 0), colspan=1, rowspan=8)
    ax111.grid(False)
    ax112 = plt.subplot2grid(gridSize, (8, 0), colspan=1, rowspan=2)
    ax112.grid(False)

    ax121 = plt.subplot2grid(gridSize, (0, 1), colspan=1, rowspan=8)
    ax122 = plt.subplot2grid(gridSize, (8, 1), colspan=1, rowspan=2)

    ax21 = plt.subplot2grid(gridSize, (10, 0), colspan=1, rowspan=10)
    ax22 = plt.subplot2grid(gridSize, (10, 1), colspan=1, rowspan=10)

    plt.subplots_adjust(hspace=10, wspace=0.2)

    plotOnAxis(df, ax111, 'blink', probeAx=ax112, summaryAx=ax21)
    if 'shock' in df.columns:
        plotOnAxis(df, ax121, 'shock', probeAx=ax122, summaryAx=ax22)


def plotSessionDir(path, outfile):
    assert path.is_dir()
    hfs = list(path.glob('*.h5'))
    print( f"[INFO ] Total {len(hfs)} hdf files found in {path}" )
    assert hfs
    m = {getTrialNumber(x.name): pd.read_hdf(x) for x in hfs}
    m = { k : v for k, v in m.items() if k >= 0 }
    res = pd.concat(m.values(), keys=m.keys(), sort=True)
    res = normalizeAndBaseline(res)

    plt.figure(figsize=(15, 10))
    plotSession(res)
    plt.savefig(outfile)
    plt.close()


def test(path):
    _, data = readTiff(path)
    plotAndSaveData(data, 'trial.png')

def test_dir(path):
    plotSessionDir(path, 'session.png')

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
