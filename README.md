# pulseaudio-docker
This is a minimal working example of a  Docker Image with PulseAudio Server that runs on a host machine that does not run a PulseAudio server.

## How To Use
1. Build the image with:
 ```shell
 $  docker build . -t pulseaudio-docker:0.0.1
 ```

 2. Start the container with:
 ```shell
 $  docker run 
     -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket
     --security-opt apparmor:unconfined
     --device /dev/snd:/dev/snd 
     -it pulseaudio-docker:0.0.1
 ```

 3. Execute command(s) that access audio resources, e.g.:
 ```
 # On Host
$ docker exec -it <containerID> speaker-test

 # or from within the container
$ speaker-test
 ```

 **Important:** 
 - If you run the container on a machine with an active PulseAudio server, make sure you stop it before starting the container:
```
# On host
$ pulseaudio --kill
```
- If debugging is required, launch the PulseAudio server with:
```
$ pulseaudio --start --exit-idle-time=-1 --daemonize=no -vvvv
```
for additional debugging information.