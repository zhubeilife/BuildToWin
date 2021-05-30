# Docker

+ run with Gui
    --user openrave \
    --mount type=bind,source=$HOME/workspace/openrave/,target=/openrave \
```bash
docker run --rm -it \
    --env="DISPLAY" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    xenial-kinetic-openrave \
    /bin/bash
```

```bash
xhost +
```
