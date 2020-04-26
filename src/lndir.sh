#!/bin/sh

set -e

. echo.sh

name=$(basename "$0" .sh)
usage="Usage: $name [-fhqr] from [to]"
help="$usage

Recursively symlink files in a directory tree.

  -f   overwrite existing regular files
  -h   display this help
  -q   do not display progress
  -r   create relative symlinks"

opts=
f=0
r=0
v=1
while getopts :fhqr opt
do
  opts="$opts -$opt"
  case $opt in
  (f)
    force=1
    ;;
  (h)
    die 0 "$help"
    ;;
  (q)
    v=0
    ;;
  (r)
    r=1
    ;;
  (:)
    warn "$name: Option '$OPTARG' requires an argument"
    die 100 "$usage"
    ;;
  (\?)
    warn "$name: Unknown option '$OPTARG'"
    die 100 "$usage"
    ;;
  esac
done
shift $((OPTIND - 1))

[[ -e "$1" ]] || die 1 "$name: Unable to read '$1': No such file or directory"
[[ -d "$1" ]] || die 1 "$name: Unable to read '$1': Not a directory"

[[ -n "$2" ]] || set -- "$1" .
[[ -d "$2" ]] || mkdir -pv "$2"

abspath() {
  [[ "$*" = /* ]] || set -- "$PWD/$*"
  typeset IFS=/ e p
  for e in $*
  do
    case "$e" in
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
}

relpath() {
  typeset a ae b be
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
  a=$(set --; IFS=/; for e in $a; do set -- "$@" ..; done; echo "$*")
  [[ -n "$a" ]] && a=$a/
  echo "$a$b"
}

ls -A "$1" | while IFS= read -r f
do
  [[ "$1/$f" -ef "$2" ]] && continue

  if [[ -d "$1/$f" ]]
  then
    "$0" $opts "$1/$f" "$2/$f"
  else
    if [[ -f "$2/$f" && ! -h "$2/$f" ]]
    then
      if [[ $force -eq 0 ]]
      then
        [[ $v -eq 1 ]] && warn "$name: Not overwriting '$2/$f'"
        continue
      fi
      rm -f "$2/$f"
    elif [[ -d "$2/$f" ]]
    then
      [[ $v -eq 1 ]] && warn "$name: '$2/$f' is a directory; skipping"
      continue
    fi

    l=$2/$f
    t=$1/$f
    [[ "$t" = /* ]] || r=1
    [[ $r -eq 1 ]] && t=$(relpath "$l" "$t")

    ln -fns "$t" "$l"
    [[ $v -eq 1 ]] && echo "'$l' -> '$t'"
  fi
done
