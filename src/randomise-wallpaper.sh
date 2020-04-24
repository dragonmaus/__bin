#!/bin/sh

cd "$(xdg-user-dir BACKGROUNDS 2> /dev/null || echo ~/Pictures/Wallpapers)"

current=$(readlink .current)

random=$current
while [[ "$random" = "$current" ]]
do
  random=$(find -L .current-res -type f 2> /dev/null | shuf | head -1)
done

ln -fns "$random" .current

[[ "$1" = -s ]] && exec set-wallpaper .current
