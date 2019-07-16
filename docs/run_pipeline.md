Docker is the recommended to run this pipeline. To get the required image,
execute `docker pull bhallalab/mousebehaviour` in the terminal.

??? note "Installing Docker"

    __Installing and checking docker__

    Follow [these instruction to install docker](https://docs.docker.com/install).
    Also see [these
    instructions](https://docs.docker.com/config/daemon/systemd/#httphttps-proxy)
    for adding proxy support to docker. To check that docker works fine, execute
    following in the terminal.

    ```bash
    $ docker run hello-world
    ```

    I saw the following output.

    ```
    Unable to find image 'hello-world:latest' locally
    latest: Pulling from library/hello-world
    1b930d010525: Pull complete 
    Digest: sha256:6540fc08ee6e6b7b63468dc3317e3303aae178cb8a45ed3123180328bcc1d20f
    Status: Downloaded newer image for hello-world:latest

    Hello from Docker!
    . 
    .
    ```

# Pipeline in Docker

The docker image is available on hub.docker.com. You can get it by executing the
following:

```bash
$ docker pull bhallalab/mousebehaviour
```

To run this image, we must make sure that docker can access
devices connected to host computer. We also need to collect data 
generated inside the docker during experiment and save it to the host machine.

!!! note
    Type `xhost +` once in the terminal. This makes docker to access
    graphics. You have to do it just once.

Following command inside the terminal did the job for me. 

Make sure that camera and Arduino Uno board are connected to host computer.
Camera requires `USB3.0` if you want high frame rate. We were able to get 200
FPS.

```bash
# camera and arduino must be connected.
docker run --rm \
    --net=host --privileged \
    -v /dev:/dev \
    -e DISPLAY=$(DISPLAY) \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $(HOME)/.Xauthority:/root/.Xauthority \
    -v $(HOME)/DATA:/root/DATA \
    -it bhallalab/mousebehaviour
```

And voila, you should see this gui. More information is [here](gui.md). When in
doubt, hover your mouse pointer on gui and a helpful message should pop-up
(hopefully).

![](images/gui_in_docker.png)


