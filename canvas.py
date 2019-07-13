# helper function for canvas.

__author__           = "Dilawar Singh"
__copyright__        = "Copyright 2019-, Dilawar Singh"
__maintainer__       = "Dilawar Singh"
__email__            = "dilawars@ncbs.res.in"

from collections import deque
from pathlib import Path
import PIL.ImageTk

figs_, txt_ = [None]*2, ""

def canvasWH(canvas):
    W, H = canvas.winfo_width(), canvas.winfo_height()
    return W, H

def addToGlobalList(obj):
    global figs_
    figs_.append(obj)
    del figs_[0]

def getLastElemFromGlobalList():
    return figs_[-1]

def drawNumpyOnCanvas(canvas, frames, data=[]):
    global txt_
    W, H = canvasWH(canvas)
    canvas.delete("all")
    for i, img in enumerate(frames):
        photo = PIL.ImageTk.PhotoImage(image = PIL.Image.fromarray(img))
        canvas.create_image(W//2, H//2, image=photo)
        addToGlobalList(photo)
        if txt_:
            canvas.delete(txt_)
        if data:
            txt_ = canvas.create_text(0, 10, text=data[i].strip(), anchor="nw")
        canvas.update()

def showImageFileOnCanvas(canvas, imgpath : Path):
    print( f"[INFO ] Showing {imgpath}" )
    img = PIL.ImageTk.PhotoImage(file=str(imgpath))
    W, H = canvasWH(canvas)
    addToGlobalList(img)
    canvas.delete("all")
    canvas.create_image(0, 0, image=img, anchor='nw')
    canvas.update()
