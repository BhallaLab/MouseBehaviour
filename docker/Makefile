VERSION := $(shell date +"%Y.%m.%d")
TAG := bhallalab/mousebehaviour:$(VERSION)

all : $(DOCKERFILE)
	docker build \
	    --build-arg http_proxy="http://172.16.223.222:3128" \
	    --build-arg https_proxy="http://172.16.223.222:3128" \
	    -t $(TAG) \
	    .

run : 
	xhost +
	docker run --rm \
	    --net=host --privileged \
	    -v /dev:/dev \
	    -e DISPLAY=$(DISPLAY) \
	    -v /tmp/.X11-unix:/tmp/.X11-unix \
	    -v $(HOME)/.Xauthority:/root/.Xauthority \
	    -v $(HOME)/DATA:/root/DATA \
	    -it $(TAG) 
