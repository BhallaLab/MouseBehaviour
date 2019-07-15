FROM ubuntu:16.04


RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y -u ppa:deadsnakes/ppa
RUN apt-get install -y git cmake g++ xterm wget curl sudo
RUN apt-get install -y libboost-all-dev libopencv-dev libserial-dev
RUN apt-get install -y xauth udev arduino-core
SHELL ["/bin/bash", "-c"]
RUN apt-get install -y python3.6-venv python3.6-tk python3.6-dev
RUN ln -s /usr/bin/python3.6 /usr/local/bin/python3
RUN ln -s /usr/bin/python3.6 /usr/local/bin/python
RUN curl https://bootstrap.pypa.io/get-pip.py | python3 - 
RUN python3 -m pip install matplotlib scipy numpy pandas pyserial
RUN python3 -m pip install pysimplegui pillow
RUN apt-get install -y libcanberra-gtk-module

# User and group creations.
RUN groupadd -f dialout 
RUN groupadd -f pgrimaging
RUN usermod -a -G dialout,pgrimaging,sudo root

# Camera udev rules.
RUN mkdir -p /etc/udev/rules.d
RUN echo "SUBSYSTEM==\"usb\", GROUP=\"pgrimaging\"" >/etc/udev/rules.d/40-pgr.rules
RUN /etc/init.d/udev restart 


WORKDIR /root

RUN git clone https://github.com/BhallaLab/MouseBehaviour
RUN ls -ltra 
RUN cd $HOME/MouseBehaviour && python3 -m pip install -r requirements.txt --user
RUN cd $HOME/MouseBehaviour && mkdir _build && cd _build && \
    cmake -DANIMAL_NAME=Z1 -DSESSION_NUM=1 -DPROTO_CODE=All1 -DPORT=/dev/ttyACM0 .. && make -j2
CMD cd $HOME/MouseBehaviour && xterm
