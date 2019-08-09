#!/usr/bin/env python3

__author__           = "Dilawar Singh"
__copyright__        = "Copyright 2019-, Dilawar Singh"
__maintainer__       = "Dilawar Singh"
__email__            = "dilawars@ncbs.res.in"

from pathlib import Path
import PySimpleGUI as sg
import methods as M
import canvas as C
import signal
import itertools
import subprocess
import tkinter as tk
import time
import sys
import serial.tools.list_ports

ports_ = [x.device for x in
        serial.tools.list_ports.comports(include_links=False)]
defaultPort_ = ports_[0] if ports_ else None

# Default size.
from screeninfo import get_monitors
try:
    m = get_monitors()[0]
    width, height = m.width * 2//3, int(m.height*1.8/3)
except Exception:
    width, height = 9000, 700

W_, H_ = width, height

if not (sys.version_info.major > 2 and sys.version_info.minor > 5):
    print( f"[ERROR] Requires python 3.6+" )
    quit(1)

# Globals.
class Args: pass
allDone_ = False

args_ = Args()

# TODO: fixme: Build and Run tab.
sizeInput = (W_//50, 1)
txtSize = (W_//40, 1)
tab1 = [ 
        [ sg.T("These values are from previous trial. REVIEW THEM!",
            key='tab1Info') ]
        , [ sg.T('AnimalName', size=txtSize), sg.In(key='ANIMAL_NAME', size=sizeInput) ]
        , [ sg.T('ProtoCode', size=txtSize), sg.In(key='PROTO_CODE', size=sizeInput) ]
        , [ sg.T('SessionNum', size=txtSize), sg.In(key='SESSION_NUM', size=sizeInput) ]
        , [ sg.T('SerialPort', size=txtSize), sg.Combo(ports_, default_value=defaultPort_, key='SERIAL_PORT', size=sizeInput)]
        , [ sg.Button('Build'), sg.Button('Run') ]
        , [ sg.Button('Clean Build Run')]
        ]

status_ = sg.Text( "STATUS", size=(100,1), key="__STATUS__")

def updateStatus(what):
    global status_
    status_.Update(what)

# canvas tabs.
canvasTabs = sg.TabGroup([[
    sg.Tab("TIFF", [[sg.Canvas(key='__CANVAS1__', size=(W_, H_))]],
        key="__TABTIFF__")
    , sg.Tab("Results", [[sg.Canvas(key='__CANVAS2__', size=(W_, H_))]],
        key="__TABRESULT__")
    ]], key="__CANVASES__"
    )

# Analysis tab.
tab2 = [ 
        [sg.In(key='session_dir', do_not_clear=True)
            , sg.FolderBrowse("Select DataDir", target='session_dir')
            , sg.Button("Find TIFF")]
        , [sg.In(key='data_dir', do_not_clear=True)
            , sg.FolderBrowse("Select ResultDir", target='data_dir'),  sg.OK()
            ]
        , [ sg.Button('Analyze All', key='Analyze')
            ,  sg.ProgressBar(1000, orientation='h', size=(40,20), key='__PROGRESS__')
            , sg.Button("Open result folder")
            ]
        , [ sg.Listbox(values=[], size=(30, H_//20), enable_events=True
            , key="__FILELIST__"
            , tooltip="Select a file to analyze"
            ), canvasTabs
            ]
        ]

layout_ = [
        [ sg.TabGroup([[
            sg.Tab('Analyze Data', tab2
                , tooltip="Analyze TIFF files")
            , sg.Tab('Behaviour Session', tab1
                , tooltip="Run experiment")
            ]], key="__TABS__", enable_events = True)
            ]
        , [sg.Exit(), status_ ]
        #  , [sg.Output( size=(3*W_//20,2))]
        ]

win_ = sg.Window('MouseBehaviour', layout_).Finalize()

class TiffFile:
    def __init__(self, path):
        self.path = Path(path)
        self.name = self.path.name

    def __str__(self):
        return self.name

    def readFrames(self):
        return M.readTiff(self.path)

    def plotData(self, data, outfile):
        outfile.parent.mkdir(parents=True, exist_ok=True)
        return M.plotAndSaveData(data, outfile=outfile, obj=self)

def openFolder(dirname):
    p = Path(dirname)
    if not p.is_dir():
        print( "[WARN] Not a directory")
        return False
    subprocess.run(["xdg-open", "."], cwd=dirname)
    return True

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
    return tiffs

def analyzeTiffDir(sessiondir, datadir):
    global win_
    global status_
    tiffs = updateTiffFileList(sessiondir)
    pgbar = win_.FindElement("__PROGRESS__")
    for i, tiff in enumerate(tiffs):
        pgbar.UpdateBar(int((i+1)*1000.0/len(tiffs)))
        status_.Update(f"Analysing {tiff}")
        analyzeTiffFile(tiff)

    # Now analyze the dir.
    summaryPlotPath = datadir / 'summary.png'
    M.plotSessionDir(datadir, summaryPlotPath)
    # Focus on results tab.
    win_.FindElement("__CANVASES__").SelectTab(1)
    canvas2 = win_.FindElement("__CANVAS2__").TKCanvas
    C.showImageFileOnCanvas(canvas2, summaryPlotPath) 
    status_.Update("ALL DONE")

def analyzeTiffFile(tiff):
    global args_
    print( f"[INFO ] Analyzing {tiff}" )
    outfile = args_.data_dir / f"{tiff}.png"
    if not outfile.exists():
        win_.FindElement("__CANVASES__").SelectTab(0)
        canvas1 = win_.FindElement("__CANVAS1__").TKCanvas
        frames, data = tiff.readFrames()
        C.drawNumpyOnCanvas(canvas1, frames)
        tiff.plotData(data, outfile)

    # Focus this tab.
    win_.FindElement("__CANVASES__").SelectTab(1)
    canvas2 = win_.FindElement("__CANVAS2__").TKCanvas
    C.showImageFileOnCanvas(canvas2, outfile) 
    time.sleep(0.2)

def initBuildEnvironment():
    global win_
    global args_

    # Make sure that build-dir exists.
    buildDir = Path(args_.build_dir)
    buildDir.mkdir(exist_ok=True)

    params = {}
    cmakeCache = buildDir / 'CMakeCache.txt'
    if cmakeCache.exists():
        print( f"[INFO ] Found CMakeCache " )
        with open(cmakeCache, 'r') as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue
                if r'//' == line[:2] or '#' == line[0]:
                    continue
                key, val = line.split('=')
                params[key.split(':')[0]] = val

    # update window params
    for x in ['ANIMAL_NAME', 'SESSION_NUM', 'PROTO_CODE']:
        win_.FindElement(x).Update(params.get(x, ''))

    # Also check if data directory has data from previous trial.
    if not args_.data_dir:
        print( f"[INFO ] No old data in {args_.data_dir}" )
        return params
    #  tiffs = findTiffFiles(args_.data_dir)
    #  if len(tiffs) > 0:
        #  tab1Info = win_.FindElement("tab1Info")
        #  tab1Info.Update( tab1Info.Get() + "\n OLD DATA FOUND!")
    return params

def cleanBuildDir():
    import shutil
    global args_
    buildDir = args_.build_dir
    shutil.rmtree(buildDir)
    buildDir.mkdir()

def build():
    global win_, args_
    buildDir = args_.build_dir
    animalName = win_.FindElement("ANIMAL_NAME").Get()
    protoCode = win_.FindElement("PROTO_CODE").Get()
    sessionNum = win_.FindElement("SESSION_NUM").Get()
    if not animalName:
        raise RuntimeError( "'Animal Name' is not specified")
    if not protoCode:
        raise RuntimeError( "'Proto Code' is not specified")
    if not sessionNum:
        raise RuntimeError( "'Session Num' is not specified")

    sourceDir = Path(__file__).parent.absolute()
    subprocess.run( [ "cmake", f"-DANIMAL_NAME={animalName}"
        , f"-DPROTO_CODE={protoCode}", f"-DSESSION_NUM={sessionNum}"
        , f"{sourceDir}"
        ], cwd = buildDir, universal_newlines=True)
    subprocess.run( [ "make"], cwd = buildDir, universal_newlines=True)

def run():
    global win_, args_
    global allDone_
    buildDir = args_.build_dir
    proc = subprocess.Popen(['make', 'run'], stdout=subprocess.PIPE
            , stderr=subprocess.PIPE
            , cwd=buildDir)
    while True:
        line = proc.stdout.readline().strip()
        if not line:
            break
        print(line)
        if allDone_:
            proc.send_signal(signal.SIGTERM)
            break
    return True

def defaultSessionDir():
    global args_
    global win_
    initBuildEnvironment()
    animalName = win_.FindElement("ANIMAL_NAME").Get()
    protoCode = win_.FindElement("PROTO_CODE").Get()
    sessionNum = win_.FindElement("SESSION_NUM").Get()
    if animalName and protoCode and sessionNum:
        return Path().home() / 'DATA' / animalName / f"{animalName}_{protoCode}_{sessionNum}"
    return ''

def updateDataDirs():
    global args_
    if not args_.session_dir:
        args_.session_dir = defaultSessionDir()

    win_.FindElement("session_dir").Update(args_.session_dir)
    updateTiffFileList(args_.session_dir)
    if args_.data_dir is None or not args_.data_dir:
        args_.data_dir = Path(args_.session_dir) / 'analysis'
    else:
        args_.data_dir = Path(args_.data_dir)
    win_.FindElement("data_dir").Update(args_.data_dir)

def main():
    global win_
    global allDone_
    updateDataDirs()
    initBuildEnvironment()
    win_.FindElement("__TABS__").SelectTab(args_.tab)
    while True:
        event, values = win_.Read()
        if event is None or event == 'Exit':
            allDone_ = True
            time.sleep(1)
            break
        elif event.lower() == 'find tiff':
            updateTiffFileList(values['session_dir'])
            args_.session_dir = Path(values['session_dir'])
            updateDataDirs()
        elif event.lower() == 'ok':
            args_.data_dir = Path(values['data_dir'])
            print( f"[INFO ] User selected data dir to {args_.data_dir}" )
            updateDataDirs()
        elif event == 'Analyze':
            analyzeTiffDir(args_.session_dir, args_.data_dir)
        elif event == "__FILELIST__":
            analyzeTiffFile( values['__FILELIST__'][0] )
        elif event.lower() == 'build':
            updateStatus("Building ...")
            build()
            updateStatus("Build Over")
        elif event.lower() == 'clean build run':
            cleanBuildDir()
            updateStatus("Building ...")
            build()
            updateStatus("Build Over")
            updateStatus("Starting trial ...")
            run()
            updateStatus('Trial is over')
        elif event.lower() == 'run':
            updateStatus("Starting trial ...")
            run()
            updateStatus('Trial is over')
        elif event.lower() == 'open result folder':
            openFolder(args_.data_dir)
        elif event.lower() == '__tabs__':
            continue
        else:
            print( f"[WARN ] Unsupported event {event}", file=sys.stderr )

    win_.Close()

if __name__ == '__main__':
    import argparse
    # Argument parser.
    description = '''GUI.'''
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('--session-dir', '-s'
            , required = False, type=Path
            , help = 'Data directory.'
            )
    parser.add_argument('--tab', '-t'
             , required = False, default = 0, type=int
             , help = 'Which tab to focus at launch. Useful during development.'
             )
    parser.add_argument('--data-dir', '-d'
             , required = False, default = None
             , help = 'Where to save the data? Default is session-dir/analysis'
             )
    parser.add_argument('--build-dir', '-b'
             , required = False, default = Path(__file__).parent / '_build'
             , help = 'build directory.'
             )
    parser.parse_args(namespace=args_)
    main()
