FROM ubuntu:16.04


RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys F23C5A6CF475977595C89F51BA6932366A755776
RUN apt-get update
RUN apt-get install -y cmake g++ xterm wget curl git
RUN apt-get install -y libboost-all-dev libopencv-dev libserial-dev
RUN apt-get install -y udev arduino-core libcanberra-gtk-module
SHELL ["/bin/bash", "-c"]
RUN apt-get install -y python3.6-venv python3.6-tk python3.6-dev
RUN ln -s /usr/bin/python3.6 /usr/local/bin/python3
RUN ln -s /usr/bin/python3.6 /usr/local/bin/python
RUN curl https://bootstrap.pypa.io/get-pip.py | python3 - 
RUN python3 -m pip install matplotlib scipy numpy pandas pyserial
RUN python3 -m pip install pysimplegui pillow

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
