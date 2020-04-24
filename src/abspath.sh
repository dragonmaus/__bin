#!/bin/sh

set -e

. echo.sh

name=$(basename "$0" .sh)
usage="Usage: $name [path]"

[[ $# -eq 0 ]] && set -- .
[[ $# -eq 1 ]] || die 1 "$usage"

[[ "$1" = /* ]] || set -- "$PWD/$1"

IFS=/
p=
for e in $1
do
  case $e in
  (''|.)
    ;;
  (..)
    p=${p%/*}
    ;;
  (*)
    p=$p/$e
    ;;
  esac
done

echo "$p"
