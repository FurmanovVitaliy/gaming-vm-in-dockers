#!/usr/bin/env bash
set -e

source /opt/bash-lib/utils.sh

export PULSE_SERVER=tcp:localhost:${PULSE_SERVER_TCP_PORT}
export PULSE_COOKIE=/home/${UNAME}/.config/pulse/cookie
export GAME="/home/${UNAME}/game/$EXECUTIONFILE"

# Проверка, что переменная UNAME установлена
if [ -z "$UNAME" ]; then
  echo "Error: UNAME is not set"
  exit 1
fi
# Создаем директорию для логов и файлы, если они не существуют
LOG_DIR="/home/${UNAME}/logs"
LOG_OUT="/home/${UNAME}/logs/protone_out" 
LOG_ERR="/home/${UNAME}/logs/protone_err"
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
# Инициализация dbus
internal_log "Setting up dbus" >> "$LOG_OUT" 
if ! eval $(dbus-launch --sh-syntax) >> "$LOG_OUT" 2>> "$LOG_ERR"; then
    internal_log "Failed to setup dbus"
    exit 1
fi
internal_log "DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS" >> "$LOG_OUT"
internal_log "Starting game in PortProton" >> "$LOG_OUT"
# Получаем расширение файла
EXT="${EXECUTIONFILE##*.}"
internal_log "File extension: $EXT" >> "$LOG_OUT"
internal_log "File path: $GAME" >> "$LOG_OUT"

# Проверяем расширение файла и выполняем соответствующие команды
if [[ "$EXT" == "exe" ]]; then
   if ! portproton "$GAME" >> "$LOG_OUT" 2>> "$LOG_ERR"; then
        internal_log "Failed to start game: $GAME" 
        exit 1
    fi
elif [[ "$EXT" == "nsp" ]]; then
    if ! /home/user/bin/yuzu/yuzu -f -g "$GAME" >> "$LOG_OUT" 2>> "$LOG_ERR"; then
        internal_log "Failed to start game: $GAME" 
        exit 1
    fi
else
    internal_log "Unsupported game-exe file type: $EXT" 
    exit 1
fi
exit 0
