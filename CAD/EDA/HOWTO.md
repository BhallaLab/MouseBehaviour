# How to use freerouter?

1. From KiCAD's `Pcbnew`,  move components to desired positions.
2. Go to `File -> Board Setup`. Select `Layers` and select `B.Cu` to layer type
   `Jumper`. We are going to make single-sided PCB. How 19th century!
3.  Export to Spectra DSN. `File -> Export -> Specctra DSN ...
4. Lauch `java -jar /opt/layout/bin/freeRouting.jar` and select the exported DSN
   file. Run autolayout. 
5. When done, save the `session file`. Import it back to kicad and we are done.
