#!/usr/bin/env bash

set -e

USERNAME="EnigmaShadow"
LOCAL_STARAGE="/home/$USER/Development/Projects/cloud-gaming-storage"
PULSE_SERVER_TCP_PORT=5001

docker run -it --network="host" \
    -e UNAME=$USERNAME \
    -e PULSE_SERVER_TCP_PORT=$PULSE_SERVER_TCP_PORT \
    -v $LOCAL_STARAGE/$USERNAME-home:/home/$USERNAME \
    arch:pulseaudio "echo Pulseaudio container is running"
