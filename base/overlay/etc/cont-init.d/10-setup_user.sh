#!/usr/bin/env bash

set -e

internal_log "**** Configure default user ****"

if [[ "${UNAME}" != "root" ]]; then
    mkdir -p /home/${UNAME} &&
    useradd -d /home/${UNAME} -s /bin/bash ${UNAME} &&
    chown -R ${UNAME} /home/${UNAME} &&
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
else
    internal_log "Container running as root. Nothing to do."
fi

internal_log "DONE"
