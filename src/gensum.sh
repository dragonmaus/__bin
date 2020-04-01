#!/bin/sh

md5 "$@"
sha256 "$@"
sha512 "$@"
stat -L -c 'SIZE (%n) = %s' "$@"
stat -L -c 'TIME (%n) = %Y' "$@"
