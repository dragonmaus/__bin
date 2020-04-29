#!/data/data/com.termux/files/usr/bin/mksh

set -e

. echo.sh

name=$(basename "$0" .sh)
usage="Usage: name [-hls]"
help="$usage

  -h   display this help
  -l   set lockscreen
  -s   set wallpaper"

l=0
s=0
while getopts :hls opt
do
  case $opt in
  (h)
    die 0 "$help"
    ;;
  (l)
    l=1
    ;;
  (s)
    s=1
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

cd "$(xdg-user-dir BACKGROUNDS)"

current=$(head -1 < .current)

random=$current
while [[ "$random" = "$current" ]]
do
  random=$(find *x* -type f 2> /dev/null | shuf | head -1)
done

echo "$random" > .current

[[ $l -eq 1 ]] && set-lockscreen "$random"
[[ $s -eq 1 ]] && set-wallpaper "$random"
