#!/bin/sh

d=
l=
s=
while getopts :dls opt
do
  case $opt in
  (d)
    d=1
    ;;
  (l)
    l=1
    ;;
  (s)
    s=1
    ;;
  (*)
    exit 1
    ;;
  esac
done
shift $((OPTIND - 1))

cd "$(xdg-user-dir BACKGROUNDS)"

desktop=$(head -1 < .current-desktop)
lockscreen=$(head -1 < .current-lockscreen)

find *x* -type f 2> /dev/null | grep -Fvx -e "$desktop" -e "$lockscreen" | shuf | head -2 | (
  IFS= read -r desktop
  IFS= read -r lockscreen

  [[ $s -eq 1 ]] && lockscreen=$desktop

  ln -fns "$desktop" .current-desktop
  ln -fns "$lockscreen" .current-lockscreen
)

[[ $d -eq 1 ]] && set-desktop .current-desktop
[[ $l -eq 1 ]] && set-lockscreen .current-lockscreen
