#!/usr/bin/env bash

add-apt-repository -y -u ppa:deadsnakes/ppa
apt-get install -y python3.6-venv python3.6-tk
python3.6 -m venv ~/PY36
source ~/PY36/bin/activate
pip install -r ../requirements.txt
