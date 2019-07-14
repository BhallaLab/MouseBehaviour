FROM ubuntu:16.04


RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y -u ppa:deadsnakes/ppa
RUN apt-get install -y python3.6-venv python3.6-tk
RUN apt-get install -y git cmake g++ 
RUN python3.6 -m venv ~/PY36
RUN source ~/PY36/bin/activate
RUN pip install matplotlib scipy numpy pandas pyserial
RUN apt-get install -y xterm 
RUN git clone https://github.com/BhallaLab/MouseBehaviour
RUN mkdir -p MouseBehaviour/_build 
RUN cd MouseBehaviour/_build && cmake .. && make 

# User and group creations.
RUN useradd -ms /bin/bash BhallaLabUser 
USER BhallaLab
WORKDIR /opt/BhallaLab

CMD xterm
