#!/bin/sh

set -e

. echo.sh

getpercent() {
    amixer sget Master \
    | sed -En \
        -e 's/^  Mono: Playback [0-9]+ \[([0-9]+)%\] \[-?[0-9]*\.[0-9]*dB\] \[o[fn]+\]$/\1/p' \
        -e 's/^  Front Left: Playback [0-9]+ \[([0-9]+)%\] \[o[fn]+\]$/\1/p' \
        -e 's/^  Front Right: Playback [0-9]+ \[([0-9]+)%\] \[o[fn]+\]$/\1/p' \
    | head -1
}

clamp() {
    if [[ $1 -lt 0 ]]
    then
        echo 0
    elif [[ $1 -gt 100 ]]
    then
        echo 100
    else
        echo $1
    fi
}
round() {
    d=$(($1 % 5))
    case $d in
    (0)
        echo $1
        ;;
    (1|2)
        echo $(($1 - $d))
        ;;
    (3|4|5)
        echo $(($1 + (5 - $d)))
        ;;
    esac
}

case "$*" in
('')
    echo $(getpercent)%
    exit 0
    ;;
(+|-)
    percent=$(getpercent)
    percent=$((percent $1 5))
    percent=$(clamp $(round $percent))
    echo $percent%
    exec amixer sset Master $percent% > /dev/null
    ;;
([0-9]|[1-9][0-9]|100)
    percent=$(clamp $1)
    echo $percent%
    exec amixer sset Master $percent% > /dev/null
    ;;
(mute)
    exec amixer sset Master toggle > /dev/null
    ;;
(*)
    die 1 "$0: Invalid argument '$1'"
    ;;
esac
