#!/usr/bin/env bash

set -e

USERNAME="EnigmaShadow"
LOCAL_STARAGE="/home/$USER/Development/Projects/cloud-gaming-storage"


docker run -it --network="host" --privileged \
    \
    --device /dev/dri/card0:/dev/dri/card0 \
    --device /dev/dri/renderD128:/dev/dri/renderD128 \
    -e UNAME=$USERNAME \
    -v $LOCAL_STARAGE/$USERNAME-home:/home/$USERNAME \
    \
    -e PLANE_ID=52 \
    -e VAAPI_DEVICE=/dev/dri/renderD128 \
    -e RESOLUTION=w=1920:h=1080 \
    -e PIX_FORMAT=nv12 \
    \
    -e THREADS=2 \
    -e FILTER_THREADS=1 \
    -e THREAD_QUEUE_SIZE=128 \
    \
    -e FPS=60 \
    -e GOP=20 \
    \
    -e CODEC=h264_vaapi \
    -e TUNE=zerolatency \
    -e PROFILE=high \
    \
    -e BITRATE=7500k \
    -e BUF_SIZE=4000k \
    \
    -e HOST_IP=127.0.0.1 \
    -e VIDEO_PORT=5000 \
    -e PKT_SIZE=1400 \
    \
    arch:ffmpeg-video
