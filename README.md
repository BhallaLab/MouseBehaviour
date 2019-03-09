[![Build Status](https://travis-ci.org/BhallaLab/MouseBehaviour.svg?branch=master)](https://travis-ci.org/BhallaLab/MouseBehaviour)

A `cmake` based C++/Python pipeline to run behavioural experiment.

# Protocols

Various protocols are supported. They are listed in
`./Protocols/BehaviourProtocols.xlsx` and (csv copy
`./Protocols/BehaviourProtocols.xlsx`). Make sure that you use the right
protocol. See section __How to run the pipeline__ below.


# What is included?

A camera server written in C++ (PointGrey Camera) and arduino based behaviour
setup (C++). Build system is based on `cmake` and uses `boost` libraries 

# How to run the pipeline 

Both arduino and camera must be connected to compute before doing the following.

## Download and setup 

This code will __only__ work on Ubuntu-16.04. Install arduino, c++ compiler
(gcc), cmake, and boost libraries. More details below.

### Dependencies

You need to install the following. Script `bootstrap.sh` will install most of
them. Required libraries for PointGrey camera is in the source.

    - sudo apt install cmake g++ libboost-all-dev
    - sudo apt install gnuplot-x11
    - sudo apt install libopencv-dev
    - sudo apt install libserial-dev
    
Download the code:

    $ git clone  https://github.com/BhallaLab/MouseBehaviour.git
    $ cd MouseBehaviour 
    $ ./bootstrap.sh    # To setup your Ubuntu system.

The script `bootstap.sh` will try to configure your system. You must have `sudo`
permissions because we need to add to various groups (`pgrimaging` and `dialout`)
before you can access camera and serial port. In case, something odd happens,
raise an issue on github. 

Once bootstrap is successful, logout and login. Changed group takes effect only
after fresh login. To verify that you are in appropriate groups, type `groups`
command in terminal. Make sure that `pgrimaging` and `dialout` appears in the
group list.  If not, things have not gone properly. 

To build and upload to arduino:

    $ mkdir _build 
    $ cd _build
    $ cmake -DANIMAL_NAME=k2 -DSESSION_NUM=1 -DSESSION_TYPE=S -DPROTO_CODE=All1 ..
    $ make run              # to run the whole setup, (arduino and camera both must be connected)or
    $ make miniterm         # Just to test arduino board. (camera need to be connected)


On `make run`, a windows will appear which shows the running plots. While sending commands
to arduino, make sure that you focus on the window (click on it). 

Press `CTRL+C` in terminal to close the session. If just running `make
miniterm`, press `CTRL+]` to come out of miniterm (scrolling text).

## CMake options

### Port

If you need to change the arduino port, pass `-DPORT=/path/to/port` option to cmake. On a linux system, e.g.

     $ cmake -DPORT=/dev/ttyACM1 -DANIMAL_NAME=k2 -DSESSION_NUM=1 -DSESSION_TYPE=2 ..

## Analysis

Analysis scripts are written in python and requires common numerical computational
framework e.g., `numpy`, `scipy`, `pandas` and additionally `tifflib`.
 
- sudo apt install python-tifflib 

# Commands

- __Puff__ : p
- __Tone__ : t
- __Led__ : l
- __Start__ : s 
- __Stop__ : ctrl+c

# What is being printed.

See function `write_data_line` in file `src/main.ino` for updated values.

# How to analyze data

Go to directory `./analysis` and read the `README.md` file there. 
