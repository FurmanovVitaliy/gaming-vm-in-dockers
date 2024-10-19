#!/bin/bash
internal_log() {
     echo "$(command date +"[%Y-%m-%d %H:%M:%S]") $*"
      }
join_by() { local IFS="$1"; shift; echo "$*"; }

