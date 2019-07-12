# helper function for canvas.

__author__           = "Dilawar Singh"
__copyright__        = "Copyright 2019-, Dilawar Singh"
__maintainer__       = "Dilawar Singh"
__email__            = "dilawars@ncbs.res.in"

import matplotlib.backends.tkagg as tkagg
from matplotlib.backends.backend_agg import FigureCanvasAgg
from collections import deque
import tkinter as tk
import PIL.ImageTk

figs_, txt_ = deque([], maxlen=2), ""

def draw_figure(canvas, figure, loc=(0, 0)):
    """ Draw a matplotlib figure onto a Tk canvas

    loc: location of top-left corner of figure on canvas in pixels.
    Inspired by matplotlib source: lib/matplotlib/backends/backend_tkagg.py
    """
    figure_canvas_agg = FigureCanvasAgg(figure)
    figure_canvas_agg.draw()
    figure_x, figure_y, figure_w, figure_h = figure.bbox.bounds
    figure_w, figure_h = int(figure_w), int(figure_h)
    photo = tk.PhotoImage(master=canvas, width=figure_w, height=figure_h)

    # Position: convert from top-left anchor to center anchor
    canvas.create_image(loc[0] + figure_w/2, loc[1] + figure_h/2, image=photo)

    # Unfortunately, there's no accessor for the pointer to the native renderer
    tkagg.blit(photo, figure_canvas_agg.get_renderer()._renderer, colormode=2)

    # Return a handle which contains a reference to the photo object
    # which must be kept live or else the picture disappears
    return photo

def drawOnCanvas(canvas, fig, data=[]):
    # Use PIL (Pillow) to convert the NumPy ndarray to a PhotoImage
    # Add a PhotoImage to the Canvas
    global figs_, txt_
    photo = draw_figure(canvas, fig)
    figs_.append(photo)
    canvas.update()

def drawNumpyOnCanvas(canvas, frames, data=[]):
    global figs_, txt_
    W, H = canvas.winfo_width(), canvas.winfo_height()
    for i, img in enumerate(frames):
        figs_.append(PIL.ImageTk.PhotoImage(image = PIL.Image.fromarray(img)))
        canvas.create_image(W//2, H//2, image=figs_[-1])
        if txt_:
            canvas.delete(txt_)
        if data:
            txt_ = canvas.create_text(0, 10, text=data[i].strip(), anchor="nw")
        canvas.update()
