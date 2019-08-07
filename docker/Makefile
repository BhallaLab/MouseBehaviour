VERSION := $(shell date +"%Y.%m.%d")
TAG := bhallalab/mousebehaviour:$(VERSION)
LATESTTAG := bhallalab/mousebehaviour:latest
CWD=$(shell pwd)

BUILD_ARGS= --build-arg http_proxy="http://172.16.223.222:3128" --build-arg https_proxy="http://172.16.223.222:3128"


all : $(DOCKERFILE)
	docker build $(BUILD_ARGS) -t $(TAG) .
	docker build $(BUILD_ARGS) -t $(LATESTTAG)  .

run : 
	xhost +
	docker run --rm \
	    --net=host --privileged \
	    -v /dev:/dev \
	    -e DISPLAY=$(DISPLAY) \
	    -v /tmp/.X11-unix:/tmp/.X11-unix \
	    -v $(CWD)/..:/root/MouseBehaviour \
	    -v $(HOME)/DATA:/root/DATA \
	    -v $(HOME)/.Xauthority:/root/.Xauthority \
	    -it $(LATESTTAG) 

upload :
	docker push $(TAG)
	docker push $(LATESTTAG)
