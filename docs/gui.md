# GUI

!!! warning "Work in progress"

GUI has two tabs. First is to analyse the `tiff` files generated during the
session and, second one to run the session.

# Protocols

A protocol must be listed in `./Protocols/BehaviourProtocols.csv`. You must
specify the right protocol code during configuration. 

## Send commands to arduino

To send commands to arduino, make sure that you focus on the window which shows
camera frames (click on it). 

Press the following character to issue corresponding command.

- `p` __Puff__ 
- `t` __Tone__
- `l` __Led__ 
- `c` __Shock__ 
- `s` __Start the session__. After pressing `s`, arduino will not accept any
  command from the user. 

To terminal the session, focus on frame window and press `q`. Or focus on the
terminal and press `Ctrl+C`. 

## What is being printed?

See function `write_data_line` in file `Arduino/main.ino`. Each line is in csv
format with 13 fields. 

```c
char msg[100];
sprintf(msg, "%lu,%s,%d,%d,%d,%d,%d,%d,%s,%d,%ld"
        , timestamp, PROTO_CODE, trial_count_
        , puff, tone, led
        , camera, microscope, trial_state_
        , shock_pin_readout, encoder_value_
);
```
