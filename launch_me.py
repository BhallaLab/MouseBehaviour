#!/usr/bin/env python3

__author__           = "Dilawar Singh"
__copyright__        = "Copyright 2019-, Dilawar Singh"
__maintainer__       = "Dilawar Singh"
__email__            = "dilawars@ncbs.res.in"

from pathlib import Path
import PySimpleGUI as sg
from analysis import read_tiff
from analysis import plot_trial
import canvas as C
import itertools

# Globals.
class Args: pass
args_ = Args()
W_, H_ = 800, 600

class TiffFile:
    def __init__(self, path):
        self.path = Path(path)
        self.name = self.path.name
        self.frames = []
        self.data = []

    def __str__(self):
        return self.name

    def readFrames(self):
        self.frames, self.data = read_tiff.readTiff(self.path)
        return self.frames, self.data

    def plotData(self, data):
        return plot_trial.plotTrial(data, self)

# Build and Run tab.
tab1 =  [[sg.T('Build and run.')]]

# canvas tabs.
canvasTabs = sg.TabGroup([[
    sg.Tab("TIFF", [[sg.Canvas(key='__CANVAS1__', size=(W_, H_))]])
    , sg.Tab("Results", [[sg.Canvas(key='__CANVAS2__', size=(W_, H_))]])
    ]], key="__CANVASES__"
    )

# Analysis tab.
tab2 = [ 
        [sg.In(key='data_dir', do_not_clear=True)
            , sg.FolderBrowse(target='data_dir')
            , sg.OK()
            , sg.Button('Analyze', key='Analyze')
            ],
        [ sg.Listbox(values=[], size=(30,25), enable_events=True
            , key="__FILELIST__"
            , tooltip="Select a file to analyze"
            ), canvasTabs
            ]
        ]

layout_ = [
        [ sg.TabGroup([[sg.Tab('Build&Run', tab1), sg.Tab('Analyze', tab2)]]
            , key="__TABS__", enable_events = True)]
        #  , [sg.Output(size=(80, 5)), sg.Exit()]
        , [ sg.Exit()]
        ]

win_ = sg.Window('MouseBehaviour', layout_).Finalize()

def findTiffFiles(datadir, ext="tif"):
    print( f"[INFO ] Analysing data in {datadir}" )
    datadir = Path(datadir)
    tiffs = []
    for x in itertools.chain(datadir.glob(f"*.{ext}"), datadir.glob(f"*.{ext}f")):
        tiffs.append(TiffFile(x))
    return tiffs

def updateTiffFileList(datadir):
    global win_
    tiffs = findTiffFiles(datadir)
    win_.FindElement("__FILELIST__").Update(tiffs)

def analyzeTiffDir(datadir):
    global win_
    updateTiffFileList(datadir)


def analyzeTiffFile(files):
    print( f"[INFO ] Analyzing {files}" )
    assert len(files) == 1
    canvas1 = win_.FindElement("__CANVAS1__").TKCanvas
    canvas2 = win_.FindElement("__CANVAS2__").TKCanvas
    tiff = files[0]  # full path.
    frames, data = tiff.readFrames()
    C.drawNumpyOnCanvas(canvas1, frames)
    fig = tiff.plotData(data)
    C.drawOnCanvas(canvas2, fig) 

def main():
    global win_
    if args_.data_dir:
        win_.FindElement("data_dir").Update(args_.data_dir)
        updateTiffFileList(args_.data_dir)

    win_.FindElement("__TABS__").SelectTab(args_.tab)

    while True:
        event, values = win_.Read()
        if event is None or event == 'Exit':
            break
        elif event == 'OK':
            updateTiffFileList(values['data_dir'])
        elif event == 'Analyze':
            analyzeTiffDir(values['data_dir'])
        elif event == "__FILELIST__":
            analyzeTiffFile( values['__FILELIST__'])
        else:
            print( f"[WARN ] Unsupported event {event}", values )
    win_.Close()

if __name__ == '__main__':
    import argparse
    # Argument parser.
    description = '''GUI.'''
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('--data-dir', '-d'
            , required = False, type=Path
            , help = 'Data directory.'
            )
    parser.add_argument('--tab', '-t'
             , required = False, default = 0, type=int
             , help = 'Which tab to focus at launch. Useful during development.'
             )
    parser.parse_args(namespace=args_)
    main()
