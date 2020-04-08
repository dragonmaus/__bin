#!/bin/sh

. echo.sh

[[ -e "$1" ]] || die 1 "Unable to read '$1': No such file or directory"
[[ -d "$1" ]] || die 1 "Unable to read '$1': Not a directory"

[[ -n "$2" ]] || set -- "$1" "$PWD"
[[ -d "$2" ]] || mkdir -pv "$2"

ls -A "$1" | while IFS= read -r f
do
  if [[ -d "$1/$f" ]]
  then
    "$0" "$1/$f" "$2/$f"
  else
    ln -fnsv "$1/$f" "$2/$f"
  fi
done
