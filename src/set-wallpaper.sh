#!/data/data/com.termux/files/usr/bin/mksh

set -e

exec > /dev/null 2>&1

termux-wallpaper -l -f "$1"
exec termux-wallpaper -f "$1"
