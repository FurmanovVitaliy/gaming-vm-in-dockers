#!/usr/bin/env bash
set -e


source /opt/bash-lib/utils.sh

export PULSE_SERVER=tcp:localhost:${PULSE_SERVER_TCP_PORT}
export PULSE_COOKIE=/home/${UNAME}/.config/pulse/cookie

# Проверка, что переменная UNAME установлена
if [ -z "$UNAME" ]; then
  echo "Error: UNAME is not set"
  exit 1
fi

# Создаем директорию для логов и файлы, если они не существуют
LOG_DIR="/home/${UNAME}/logs"
LOG_OUT="/home/${UNAME}/logs/ffmpeg_audio_out"
LOG_ERR="/home/${UNAME}/logs/ffmpeg_audio_err"
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

# ffmpeg comand for rtp streaming
command="ffmpeg \
    -f pulse -re -i default \
    -c:a libopus \
    -f rtp rtp://${HOST_IP}:${AUDIO_PORT}?pkt_size=${PKT_SIZE} " 

if ! eval "$command" >> "$LOG_OUT" 2>> "$LOG_ERR"; then
    internal_log "Failed to execute ffmpeg command: $command"
    exit 1
fi
exit 0