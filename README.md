# eyeBlinkBehaviour

Camera server (PointGrey) and arduino based behaviour setup. Everything is
automated using cmake.

To build and upload to arduino   

    $ mkdir _build 
    $ cd _build
    $ cmake ..
    $ make run              # to run the whole setup, or
    $ make miniterm         # Just to test arduino board. 


# Dependencies

- cmake 
- gnuplot-x11
- pip install readchar


# Commands

- __Puff__ : p
- __Tone__ : t
- __Led__ : l
- __Select__ : s 
- __Reboot__ : ctrl+c

# Print data line 

    sprintf(msg_  
            , "%lu,%d,%d,%d,%d,%d,%d,%d,%d,%s"
            , timestamp, trial_count_, puff, tone, led
            , motion1, motion2, camera, microscope, trial_state_
            );

# How to disable mouse pointer 

- https://unix.stackexchange.com/questions/388053/disable-mouse-pointer-but-read-the-mouse-events
- http://www.nico.schottelius.org/blog/xorg-disable-touchpad-with-xinput/
