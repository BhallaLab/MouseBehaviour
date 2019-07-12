__author__           = "Dilawar Singh"
__copyright__        = "Copyright 2019-, Dilawar Singh"
__maintainer__       = "Dilawar Singh"
__email__            = "dilawars@ncbs.res.in"

# read a tiff file and return frames.

from PIL import Image
import numpy as np

def readTiff(filepath):
    img = Image.open(filepath)
    data, frames = [], []
    for i in range(img.n_frames):
        img.seek(i)
        f = np.array(img)
        frames.append(f)
        line = [chr(x) for x in f[0,:]]
        data.append(''.join(line))
    return frames, data
