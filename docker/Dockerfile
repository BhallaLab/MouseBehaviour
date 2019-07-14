FROM ubuntu:16.04


RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y -u ppa:deadsnakes/ppa
RUN apt-get install -y git cmake g++ xterm wget curl
RUN apt-get install -y libboost-all-dev libopencv-dev libserial-dev
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

RUN git clone https://github.com/BhallaLab/MouseBehaviour
RUN mkdir -p MouseBehaviour/_build 
RUN cd MouseBehaviour/_build && cmake .. && make 


CMD xterm
