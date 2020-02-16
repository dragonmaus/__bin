#!/bin/sh

[[ "$( id -u )" -eq 0 ]] || export SVDIR="$HOME/etc/runit/runsvdir"

exec /usr/bin/sv "$@"
