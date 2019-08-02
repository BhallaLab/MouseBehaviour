# Required Hardware

Name | Vendor | Quantity | Remarks 
-----|--------|----------|---------
BFS-U3-13Y3M Camera | FLIR Inc. | 1 | Point Gray Black Fly Camera
PMC8-6106  Rotary Encoder | Rhino Motion | 1 | 2000 rotation/cycle
Arduino Board | Arduino | 1 | Arduino Uno

# Designs

EDA designs are in the folder `CAD/EDA`. It requires
[KiCAD](http://kicad-pcb.org/) version 5 or higher. The final PCB design is also
available on various releases (one is available at
https://github.com/BhallaLab/MouseBehaviour/releases/tag/v2019.08.02 ).

!!! note "Following snapshot may be outdated"
        See the github repo release page for latest design and schematic.

![PCB
designed](https://user-images.githubusercontent.com/895681/60946325-8a31d480-a30b-11e9-8366-f0b81a107433.png)

And [see the
schematic](https://github.com/BhallaLab/MouseBehaviour/releases/download/v2019.07.10/Schematic.pdf).

# Generating layout using FreeRouter

1. From KiCAD's Pcbnew, move components to desired positions.
2. Go to File -> Board Setup. Select Layers and select `B.Cu` to layer type
   `Jumper`. We are going to make single-sided PCB. We don't have a PCB machine
   which can fabricate two sided PCB easily!
3. Now draw the tracks manually, or do it automatically using `freeRouting.jar`
   file.
4. Export to Spectra DSN. `File -> Export -> Specctra DSN ...`
5. Lauch `java -jar /opt/layout/bin/freeRouting.jar` and select the exported DSN
   file. Run `autolayout`.
6. When done, save the session file. Import it back to kicad.

Consult electronic workshop before fabricating the PCB. You may have to fill the
PCB after auto-routing. Otherwise you'd end up removing too much of copper using
the machine. See [this
page](https://github.com/KiCad/kicad-doc/blob/master/src/pcbnew/pcbnew_zones.adoc).
