#!/usr/bin/env python3

__author__ = "Dilawar Singh"
__copyright__ = "Copyright 2016, Dilawar Singh"
__credits__ = ["NCBS Bangalore"]
__license__ = "GNU GPL"
__version__ = "1.0.0"
__maintainer__ = "Dilawar Singh"
__email__ = "dilawars@ncbs.res.in"
__status__ = "Development"

import sys
import os
import datetime
import numpy as np
import pickle
import cv2
from libtiff import TIFF
import matplotlib as mpl
# mpl.use( 'pgf' )
import matplotlib.pyplot as plt
try:
    mpl.style.use(['bmh', 'fivethirtyeight'])
except Exception as e:
    pass
fmt_ = "%Y-%m-%dT%H:%M:%S.%f"
eyeLoc_ = []

def parse_timestamp(tstamp):
    global fmt_
    date = datetime.datetime.strptime(tstamp, fmt_)
    return date

def get_status_timeslice(data, status):
    status = [x for x in data if x[-5] == status]
    if not status:
        return None, None
    if len(status) > 2:
        startTime = parse_timestamp(status[0][1])
        endTime = parse_timestamp(status[-1][1])
        if startTime is None or endTime is None:
            return None, None
    else:
        startTime, endTime = 0, 0
    return startTime, endTime


def compute_learning_yesno(time, blink, cs_start_time):
    baseline, signal = [], []
    for t, v in zip(time, blink):
        t1 = (t - cs_start_time).total_seconds()
        if t1 > -0.200 and t1 <= 0:
            baseline.append(v)
        # 50ms from the starting of CS
        if t1 >= 0.050 and t1 <= 0.300:
            signal.append(v)

    baseline = np.array(baseline)
    baseMean, baseStd = np.mean(baseline), np.std(baseline)
    signal = np.array([abs(x - baseMean) for x in signal])
    hasLearnt = False
    if max(signal) > 2 * baseStd:
        hasLearnt = True
    return baseline, signal, hasLearnt

def show_frame(frame):
    cv2.imshow("Frame", frame)
    cv2.waitKey(1)


def detectEye(frame, cascade, plot):
    global eyeLoc_
    frame = cv2.equalizeHist(frame)
    kernel = np.ones((3, 3), np.uint8)
    frame = cv2.morphologyEx(frame, cv2.MORPH_OPEN, kernel)

    eyes = cascade.detectMultiScale(frame, scaleFactor=1.05
            , minNeighbors=20, minSize=(150, 150), maxSize=(350, 350)
            )

    blink = False
    if len(eyes) < 1:
        # Use the last known position of eye. May be get the mean.
        blink = True
        x0, y0, w0, h0 = np.mean(eyeLoc_, axis=0)
        x, y, w, h = int(x0), int(y0), int(w0), int(h0)
    else:
        x, y, w, h = sorted(eyes, key=lambda x: x[-1]*x[-2])[-1]
        eyeLoc_.append((x,y,w,h))
    eyesImg = frame[y:y+h, x:x+w]
    if plot:
        if blink:
            cv2.putText(eyesImg, 'BLINK', (10,10), cv2.FONT_HERSHEY_SIMPLEX,
                    0.5, 255, 1
                    )
        show_frame(eyesImg)
    return np.mean(eyesImg)

def process(**kwargs):
    tifffile = kwargs['input']
    print('[INFO] Processing %s' % tifffile)
    tf = TIFF.open(tifffile)
    frames = tf.iter_images()
    datalines, arduinoData = [], []
    trialType = 'NA'

    # If classfier is found. Use it.
    classifierFile = kwargs.get('classifier', '')
    cascade = None
    if classifierFile and os.path.isfile(classifierFile):
        cascade = cv2.CascadeClassifier(classifierFile)

    classifierValues = []
    for fi, frame in enumerate(frames):
        # print( frame.shape )
        binline = frame[0, :]
        txtline = (''.join(([chr(x) for x in binline]))).rstrip()
        data = txtline.split(',')
        if len(data) > 1:
            datalines.append(data)
        if len(data) > 2:
            arduinoData.append(data)

        if cascade is not None:
            blinkValue = detectEye(frame, cascade, kwargs['plot'])
            classifierValues.append(blinkValue)

    tvec, blinkVec, velocityVec = [], [], []
    for l in datalines:
        if len(l) > 5:
            if l[-5] == 'CS+':
                tone, led = int(l[6]), int(l[7])
                if led == 1:
                    trialType = 'LIGHT NO SOUND'
                elif tone == 1:
                    trialType = 'SOUND NO LIGHT'
        try:
            tvec.append(parse_timestamp(l[0]))
            blinkVec.append(float(l[-1]))
            velocityVec.append(float(l[-2]))
        except Exception as e:
            print('[WARN] Failed to parse data line %s. Ignoring' % l)
            print('\t Error was %s' % e)

    if cascade is not None:
        blinkVec = classifierValues

    mean_ = sum(blinkVec) / len(blinkVec)
    cspST, cspET = get_status_timeslice(arduinoData, 'CS+')
    assert cspST, arduinoData
    usST, usET = get_status_timeslice(arduinoData, 'PUFF')
    probeTs = get_status_timeslice(arduinoData, 'PROB')

    if probeTs[0] is None and probeTs[1] is None:
        # Nowhere we found PROB in trial.
        isProbe = False
    else:
        print('[INFO] Trial %s is a PROBE trial' % tifffile)
        isProbe = True

    # Computer perfornace of this trial.
    baseline, signal, hasLearnt = compute_learning_yesno(tvec, blinkVec, cspST)
    if hasLearnt:
        print('|| Learning in %s' % tifffile)

    temp = os.path.join(os.path.dirname(tifffile), '_results')
    datadir = kwargs.get('outdir',  temp)
    if datadir and not os.path.isdir(datadir):
        os.makedirs(datadir)

    if kwargs.get('plot', False):
        ax = plt.subplot(211)
        if cspET > cspST:
            ax.plot([cspST, cspET], [mean_, mean_])

        if (usET and usST) and usET > usST:
            ax.plot([usST, usET], [mean_, mean_])

        ax.plot(tvec, blinkVec, label='Learning? %s' % hasLearnt)
        ax.axhline(y=np.mean(baseline) + np.std(baseline))
        plt.title('Trial Type=%s' % trialType)
        plt.legend(framealpha=0.4)
        plt.title(os.path.basename(sys.argv[1]), fontsize=8)

        ax2 = plt.subplot(212, sharex=ax)
        ax2.plot(tvec, velocityVec, label='Speed')
        plt.xlabel('Time')
        plt.ylabel('cm/sec (really?)')

        outfile = os.path.join(datadir, '%s.png' % os.path.basename(tifffile))
        plt.tight_layout(pad=3)
        plt.savefig(outfile)
        plt.close()
        print('Saved to %s' % outfile)

    # Write processed data to pickle.
    print('[INFO] Trial type %s' % trialType)
    res = dict(time=tvec, blinks=blinkVec, cs=[cspST, cspET], us=[usST, usET], did_learn=hasLearnt, is_probe=isProbe, trial_type=trialType
               )

    pickleFile = os.path.join(
        datadir, '%s.pickle' % os.path.basename(tifffile)
    )

    with open(pickleFile, 'wb') as pF:
        pickle.dump(res, pF)

    print('[INFO] Wrote pickle %s' % pickleFile)
    return res


def main(**kwargs):
    process(**kwargs)

if __name__ == '__main__':
    import argparse
    # Argument parser.
    description = '''Analyze a single tiff file'''
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('--input', '-i', required=True, help='Input TIFF file'
            )
    parser.add_argument('--outdir', '-o', default=''
            , required=False, help='Output directory'
            )
    parser.add_argument('--classifier', '-c', required=False, default='', help='Classifier file'
            )
    parser.add_argument('--plot', '-p', action='store_true', default=False, help='Plot while analysing.'
            )

    class Args:
        pass
    args = Args()
    parser.parse_args(namespace=args)
    main(**vars(args))
