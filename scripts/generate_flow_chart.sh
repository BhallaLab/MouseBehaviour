#!/usr/bin/env bash
# NOTE: Install cflow and graphviz.
set -x
set -e
CFLOW_FILE=/tmp/arduino.cflow
MAIN_C_FILE=../Arduino/main.ino
OUT_DOT_FILE=/tmp/arduino.dot
cflow -d 2 $MAIN_C_FILE > $CFLOW_FILE
~/Scripts/cflow2dot.pl < ${CFLOW_FILE} > ${OUT_DOT_FILE}
dot -Grankdir=LR -Tpng < $OUT_DOT_FILE > output.png
