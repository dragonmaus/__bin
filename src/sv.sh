#!/bin/sh

[[ $(id -u) -eq 0 ]] || export SVDIR=~/etc/runit/runsvdir

exec /usr/bin/sv "$@"
