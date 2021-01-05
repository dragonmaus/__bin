#!/bin/sh

set -e

. echo.sh

pass "$@" | {
    read -r pass
    while IFS=: read -r key value
    do
        case "$key" in
        (uri)
            host=${value#*://}
            host=${host%%/*}
            ;;
        (user)
            user=$value
            ;;
        esac
    done
    set --
    [[ -n "$host" ]] && set -- "$@" machine "$host"
    [[ -n "$user" ]] && set -- "$@" login "$user"
    [[ -n "$pass" ]] && set -- "$@" password "$pass"
    echo "$*"
}
