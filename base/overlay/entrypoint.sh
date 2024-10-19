#!/usr/bin/env bash

set -e

# Source functions from utils
source /opt/bash-lib/utils.sh

# Execute all container init scripts. Only run this if the container is started as the root user
if [ "$(id -u)" = "0" ]; then
    for init_script in /etc/cont-init.d/*.sh ; do
        internal_log
        internal_log "[ ${init_script}: executing... ]"
        sed -i 's/\r$//' "${init_script}"
        # shellcheck source=/dev/null
        source "${init_script}"
    done
fi


if [ -n "${@:-}" ]; then
    /bin/bash -c "$@"
fi

#
# Launch startup script as 'UNAME' user (some services will run as root)
internal_log "Launching the container's startup script as user '${UNAME}'"
chmod +x /opt
exec gosu "${UNAME}" /opt/startup.sh

