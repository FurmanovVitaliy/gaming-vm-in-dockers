#!/usr/bin/env bash
#xhost +local:docker


echo $XAUTHORITY
docker run --cpus="8" -it --privileged --network="host" \
    -e UNAME=EnigmaShadow \
    -v $XAUTHORITY:/home/EnigmaShadow/.Xauthority:rw \
    -e EXECUTIONFILE=eldenring.exe \
    -e DISPLAY=:0.1 \
    -e PULSE_SERVER_TCP_PORT=4713 \
    \
    -v /home/vitalii/Development/Projects/cloud-gaming-storage/EnigmaShadow-home:/home/EnigmaShadow \
    -v /home/vitalii/Games/Win/Elden:/home/EnigmaShadow/game \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    \
    --device /dev/input/event0:/dev/input/event99 \
    \
    arch:portprotone
