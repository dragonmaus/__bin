#!/bin/sh

mode=fill
while getopts :cfmst opt
do
  case $opt in
  (c) mode=center ;;
  (f) mode=fill   ;;
  (m) mode=max    ;;
  (s) mode=scale  ;;
  (t) mode=tile   ;;
  (*) break       ;;
  esac
done
shift $((OPTIND - 1))

exec feh --no-fehbg --bg-$mode "$@"
