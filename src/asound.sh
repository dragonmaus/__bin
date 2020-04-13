#!/bin/sh

case "$1" in
(headset|speaker)
  exec ln -fnsv .asoundrc.$1 ~/.asoundrc
  ;;
(toggle)
  case "$(readlink ~/.asoundrc)" in
  (.asoundrc.headset)
    exec "$0" speaker
    ;;
  (.asoundrc.speaker)
    exec "$0" headset
    ;;
  esac
  ;;
esac
