#!/usr/bin/env bash

set -e

USERNAME="EnigmaShadow"
LOCAL_STARAGE="/home/$USER/Development/Projects/cloud-gaming-storage"



docker run -it --network="host" --privileged  \
    \
    -e UNAME=$USERNAME \
    -v $LOCAL_STARAGE/$USERNAME-home:/home/$USERNAME \
    \
    -e PULSE_SERVER_TCP_PORT=4713 \
    \
    -e HOST_IP=127.0.0.1 \
    -e AUDIO_PORT=5000 \
    -e PKT_SIZE=1400 \
    \
    arch:ffmpeg-audio "sleep 5"
