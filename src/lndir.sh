#!/bin/sh

. echo.sh

[[ -e "$1" ]] || die 1 "Unable to read '$1': No such file or directory"
[[ -d "$1" ]] || die 1 "Unable to read '$1': Not a directory"

[[ -n "$2" ]] || set -- "$1" .
[[ -d "$2" ]] || mkdir -pv "$2"

ls -A "$1" | while IFS= read -r f
do
  [[ "$1/$f" -ef "$2" ]] && continue
  if [[ -d "$1/$f" ]]
  then
    if [[ "$1" = /* ]]
    then
      "$0" "$1/$f" "$2/$f"
    else
      env LNDIR_PREFIX="../$LNDIR_PREFIX" "$0" "$1/$f" "$2/$f"
    fi
  else
    ln -fnsv "$LNDIR_PREFIX$1/$f" "$2/$f"
  fi
done
