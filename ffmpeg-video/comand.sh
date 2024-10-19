#!/usr/bin/env bash
set -e


PLANE_ID=52
VAAPI_DEVICE=/dev/dri/renderD128

RESOLUTION=w=1920:h=1080
PIX_FORMAT=nv12

THREADS=2
FILTER_THREADS=1
THREAD_QUEUE_SIZE=64

FPS=60
GOP=60

CODEC=h264_vaapi
TUNE=film

PRESET=fast
PROFILE=high

BITRATE=800k
BUF_SIZE=0

HOST_IP=127.0.0.1
VIDEO_PORT=5000
PKT_SIZE=1400



# ffmpeg comand for rtp streaming
command="sudo ffmpeg \
    -plane_id $PLANE_ID \
    -vaapi_device $VAAPI_DEVICE \
    -f kmsgrab -i - \
    -vf 'hwmap=derive_device=vaapi,scale_vaapi=${RESOLUTION}:format=${PIX_FORMAT}' \
    \
    -threads:v $THREADS -filter_threads $FILTER_THREADS \
    -thread_queue_size $THREAD_QUEUE_SIZE \
    \
    -framerate $FPS\
    -r $FPS \
    \
    -c:v $CODEC \
    -tune $TUNE \
    -preset $PRESET \
    -profile:v $PROFILE \
    \
    -b:v $BITRATE \
    -maxrate $BITRATE \
    -bufsize $BUF_SIZE \
    \
    -f mpegts \
    -f rtp 'rtp://$HOST_IP:$VIDEO_PORT?pkt_size=$PKT_SIZE'"

eval "$command"
exit 0


