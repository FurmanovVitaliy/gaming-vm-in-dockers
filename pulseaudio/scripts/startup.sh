#!/usr/bin/env bash

set -e

source /opt/bash-lib/utils.sh
export PULSE_SERVER_TCP_PORT
# Проверка, что переменная UNAME установлена
if [ -z "$UNAME" ]; then
  echo "Error: UNAME is not set"
  exit 1
fi

LOG_DIR="/home/${UNAME}/logs"
LOG_OUT="${LOG_DIR}/pulseaudio_out"
LOG_ERR="${LOG_DIR}/pulseaudio_err"
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

internal_log "Setting up dbus" >> "$LOG_OUT"
if eval $(dbus-launch --sh-syntax); then
  internal_log "DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS" >> "$LOG_OUT"
else
  internal_log "Error setting up dbus" >> "$LOG_ERR"
  exit 1
fi

internal_log "Starting pulseaudio" >> "$LOG_OUT"
if ! pulseaudio --disallow-exit --disallow-module-loading --exit-idle-time=-1 --load="module-native-protocol-tcp auth-anonymous=1 port=$PULSE_SERVER_TCP_PORT}" >> "$LOG_OUT" 2>> "$LOG_ERR"; then
  internal_log "Failed to start pulseaudio" >> "$LOG_ERR"
  exit 1
fi
 exit 0
