#!/usr/bin/env bash
set -x
set -e
REPOHOME=$HOME/MouseBehaviour
BUILDIR=$REPOHOME/_docker_build
rm -rf $BUILDIR && mkdir -p $BUILDIR

# Build 
cd $BUILDIR
cmake -DANIMAL_NAME=Z1 -DSESSION_NUM=1 -DPROTO_CODE=All1 -DPORT=/dev/ttyACM0 ..  
make -j2 

# Launch
cd .. && python3 gui.py --build-dir $BUILDIR
