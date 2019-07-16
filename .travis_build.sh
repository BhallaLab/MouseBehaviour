#!/usr/bin/env bash

make -f Makefile.arduino 
cd ./PointGreyCamera && cmake . && make 
