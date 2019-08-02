# Components

## Hardware

- Arduino Uno borad
- PointGrey camera

## CAD

Electrical cad designs are in the folder `CAD/EDA`. It requires
[KiCAD](http://kicad-pcb.org/) version 5 or higher. The final PCB design is also
available on various releases (one is available at
https://github.com/BhallaLab/MouseBehaviour/releases/tag/v2019.07.10 ).

![PCB
designed](https://user-images.githubusercontent.com/895681/60946325-8a31d480-a30b-11e9-8366-f0b81a107433.png)

And [see the
schematic](https://github.com/BhallaLab/MouseBehaviour/releases/download/v2019.07.10/Schematic.pdf).

# Run the pipeline


# Generating layout using FreeRouter

1. From KiCAD's Pcbnew, move components to desired positions.
2. Go to File -> Board Setup. Select Layers and select B.Cu to layer type Jumper. We are going to make single-sided PCB. How 19th century!
3. Export to Spectra DSN. `File -> Export -> Specctra DSN ...`
4. Lauch `java -jar /opt/layout/bin/freeRouting.jar` and select the exported DSN
   file. Run `autolayout`.
5. When done, save the session file. Import it back to kicad.
