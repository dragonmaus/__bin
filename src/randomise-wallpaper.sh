#!/bin/sh

cd ~/desk/pictures/wallpapers

current=$(readlink .current)

random=$current
while [[ "$random" = "$current" ]]
do
  random=$(find -L .current-res -type f 2> /dev/null | sort -R | head -1)
done

ln -fhs "$random" .current

[[ "$1" = -s ]] && exec set-wallpaper .current
