#!/bin/sh

set -e

host=$(sed -n 's/^Host \(.*\) # menu$/\1/p' < ~/.ssh/config | sort -u | dmenu)
[[ -n $host ]]

exec st -e ssh "$host" "$@"
