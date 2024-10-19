#!/usr/bin/env bash
set -e

source /opt/bash-lib/utils.sh

# Проверка, что переменная UNAME установлена
if [ -z "$UNAME" ]; then
  echo "Error: UNAME is not set"
  exit 1
fi

# Создаем директорию для логов и файлы, если они не существуют
LOG_DIR="/home/${UNAME}/logs"
LOG_OUT="/home/${UNAME}/logs/ffmpeg_video_out"
LOG_ERR="/home/${UNAME}/logs/ffmpeg_video_err"
echo ""> "$LOG_OUT"
echo ""> "$LOG_ERR"

# Проверка успешности создания директорий и файлов
if ! mkdir -p "$LOG_DIR"; then
  echo "Error: Could not create log directory"
  exit 1
fi

if ! touch "$LOG_OUT" "$LOG_ERR"; then
  echo "Error: Could not create log files"
  exit 1
fi

internal_log "See logs in host storage at $LOG_DIR"

# Команда ffmpeg для RTP стриминга
command="sudo ffmpeg \
    -plane_id $PLANE_ID \
    -vaapi_device $VAAPI_DEVICE \
    -f kmsgrab -i - \
    -vf 'hwmap=derive_device=vaapi,scale_vaapi=${RESOLUTION}:format=${PIX_FORMAT}' \
    -threads:v $THREADS -filter_threads $FILTER_THREADS \
    -thread_queue_size $THREAD_QUEUE_SIZE \
    -framerate $FPS \
    -r $FPS \
    -g $GOP \
    -c:v $CODEC \
    -tune $TUNE \
    -preset $PRESET \
    -profile:v $PROFILE \
    -b:v $BITRATE \
    -maxrate $BITRATE \
    -bufsize $BUF_SIZE \
    -f mpegts \
    -f rtp 'rtp://$HOST_IP:$VIDEO_PORT?pkt_size=$PKT_SIZE'"

# Выполнение команды ffmpeg и логирование вывода
if ! eval "$command" >> "$LOG_OUT" 2>> "$LOG_ERR"; then
    internal_log "Failed to execute ffmpeg command: $command" 
    internal_log "Failed to execute ffmpeg command: $command" >> "$LOG_ERR"
    exit 1
fi
exit 0
