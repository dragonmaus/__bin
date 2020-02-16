#!/bin/sh

case "$1" in
(headset|speaker)
  exec ln -fsv ".asoundrc.$1" "$HOME/.asoundrc"
  ;;
(toggle)
  case "$( readlink "$HOME/.asoundrc" )" in
  (.asoundrc.headset)
    exec "$0" speaker
    ;;
  (.asoundrc.speaker)
    exec "$0" headset
    ;;
  esac
  ;;
esac
