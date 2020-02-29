#!/data/data/com.termux/files/usr/bin/mksh

name="$( basename "$0" .sh )"
next="$( which -a "$name" | sed "0,\\;^$0\$;d" | head -1 )"

setsid -w "$next" -Nfn "$@"
exec "$next" "$@"
