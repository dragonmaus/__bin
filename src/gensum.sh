#!/bin/sh

md5 "$@"
sha256 "$@"
sha512 "$@"
stat -L -f 'SIZE (%N) = %z' "$@"
stat -L -f 'TIME (%N) = %m' "$@"
