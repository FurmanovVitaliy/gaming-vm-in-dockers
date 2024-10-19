#!/usr/bin/env bash
set -e

source /opt/bash-lib/utils.sh
dbus-uuidgen > /var/lib/dbus/machine-id
internal_log "Machine id created : $(cat /var/lib/dbus/machine-id)"
