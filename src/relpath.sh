#!/data/data/com.termux/files/usr/bin/mksh

set -e

. echo.sh

name=$(basename "$0" .sh)
usage="Usage: $name [from] to"

[[ $# -eq 1 ]] && set -- . "$1"
[[ $# -eq 2 ]] || die 1 "$usage"

a=$(abspath "$1")
b=$(abspath "$2")
a=${a%/*}/

# strip common prefix
while :
do
  ae=${a%%/*}
  be=${b%%/*}
  if [[ "$ae" = "$be" ]]
  then
    a=${a#*/}
    b=${b#*/}
  else
    break
  fi
done

# transform foo/bar/baz into ../../..
a=$(
  set --
  IFS=/
  for e in $a
  do
    set -- "$@" ..
  done
  echo "$*"
)
[[ -n "$a" ]] && a=$a/

echo "$a$b"
