#!/bin/sh

md5 "$@"
sha256 "$@"
sha512 "$@"
stat -c 'SIZE (%n) = %s' "$@"
stat -c 'TIME (%n) = %Y' "$@"
