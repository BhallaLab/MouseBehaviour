FROM ubuntu:16.04


RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y -u ppa:deadsnakes/ppa
RUN apt-get install -y git cmake g++ xterm wget curl sudo
RUN apt-get install -y libboost-all-dev libopencv-dev libserial-dev
RUN apt-get install -y xauth
SHELL ["/bin/bash", "-c"]
RUN apt-get install -y python3.6-venv python3.6-tk python3.6-dev
RUN ln -s /usr/bin/python3.6 /usr/local/bin/python3
RUN ln -s /usr/bin/python3.6 /usr/local/bin/python
RUN curl https://bootstrap.pypa.io/get-pip.py | python3 - 
RUN python3 -m pip install matplotlib scipy numpy pandas pyserial

# User and group creations.
#RUN useradd -s /bin/bash --home /home/chuha -m chuha 
#USER chuha
#WORKDIR /home/chuna
#RUN chown -c chuha:root /home/chuha 
#RUN pwd  && ls -ltra


RUN export uid=1000 gid=1000 && \
    mkdir -p /home/chuha && \
    echo "chuha:x:${uid}:${gid}:Developer,,,:/home/chuha:/bin/bash" >> /etc/passwd && \
    echo "chuha:x:${uid}:" >> /etc/group && \
    echo "chuha ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/chuha && \
    chmod 0440 /etc/sudoers.d/chuha && \
    chown ${uid}:${gid} -R /home/chuha

USER chuha
ENV HOME /home/chuha
WORKDIR /home/chuha 

RUN git clone https://github.com/BhallaLab/MouseBehaviour
RUN ls -ltra 
RUN cd $HOME/MouseBehaviour/PointGreyCamera && cmake . && make && sudo make install
CMD cd $HOME/MouseBehaviour && ./gui.py
