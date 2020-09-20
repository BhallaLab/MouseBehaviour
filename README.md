[![Build Status](https://travis-ci.org/BhallaLab/MouseBehaviour.svg?branch=master)](https://travis-ci.org/BhallaLab/MouseBehaviour) ![Docker Pulls](https://img.shields.io/docker/pulls/bhallalab/mousebehaviour.svg?style=plastic)

__Documents__ https://bhallalab.github.io/MouseBehaviour

A C++/Python pipeline to run behavioural experiment.

# Protocols

A protocols must be listed in `./Protocols/BehaviourProtocols.csv`. You must specify the right
protocol code duging cmake configuration. See section __How to run the pipeline__ below.

# How to run the pipeline 

The Arduino uno board and the camera should be connected to the computer before starting the 
session.

## Download and setup (done once) 

This application works __only__ on Ubuntu-18.04 because of the camera firmware available in this repository 
from PointGrey Inc works only with Ubuntu 18.04. 

Install arduino, c++ compiler (gcc), cmake, and boost libraries.

Script `bootstrap.sh` will try to install all dependencies. Required
libraries for PointGrey camera is in the source.
    
    $ git clone  https://github.com/BhallaLab/MouseBehaviour.git
    $ cd MouseBehaviour 
    $ sudo -E ./bootstrap.sh  # If it fails, manual configuration is needed.

Once bootstrap is successful, logout and login. Changes made to your groups comes
into effect only after a fresh login. To verify that you are in appropriate groups, type `groups`
command in terminal. Make sure that `flirimaging` and `dialout` appears in the
group list.

To build and upload to arduino:

    $ mkdir _build 
    $ cd _build
    $ cmake -DANIMAL_NAME=k2 -DSESSION_NUM=1 -DPROTO_CODE=All1 ..
    $ make run              # to run the whole setup, (arduino and camera both must be connected)or
    $ make miniterm         # Just to test arduino board. (camera need to be connected)


On `make run`, a windows will appear with camera feed and couple of plots at the bottom.

## Send commands to arduino

To send commands to arduino, make sure that you focus on the window first (click on it). 

Press `CTRL+C` in terminal to close the session. To see the arduino output in the console,
run `make miniterm`; and press `CTRL+]` to come out of miniterm.

## CMake options

### Port

If you need to change the arduino port, pass `-DPORT=/path/to/port` option to cmake. On a linux system, e.g.

     $ cmake -DPORT=/dev/ttyACM1 -DANIMAL_NAME=k2 -DSESSION_NUM=1 -DPROTO_CODE=A11 ..

## Analysis

Analysis scripts are written in python and requires common numerical computational
framework e.g., `numpy`, `scipy`, `pandas` and additionally `tifflib`.
 
- sudo apt install python-tifflib 

# Commands

- __Puff__ : p
- __Tone__ : t
- __Led__ : l
- __Start__ : s 
- __Shock__ : c
- __Terminate__ : ctrl+c

# What is being printed?

See function `write_data_line` in file `src/main.ino` for updated values.

# How to analyze data

Go to directory `./analysis` and read the `README.md` file there. 

# Extracting arduino data from tiff file.

Each tiff file contains one trial. The first row of each frame contains arduino
data. You can extract that using the script
`./analysis/get_data_line_from_tiff.py` file. 

To extract data run, 

    $ python ./analysis/get_data_line_from_tiff.py /path/to/session/trial01.tiff

It will print the csv files onto the terminal and also save it to a dat file in
the same folder. A plot file is also generated.
