#!/data/data/com.termux/files/usr/bin/mksh

set -e

. echo.sh

cd "$(xdg-user-dir BACKGROUNDS)"

current=$(head -1 < .current)

random=$current
while [[ "$random" = "$current" ]]
do
  random=$(find *x* -type f 2> /dev/null | shuf | head -1)
done

echo "$random" > .current

[[ "$1" = -s ]] && exec set-wallpaper "$random"
