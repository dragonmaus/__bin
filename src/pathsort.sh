#!/data/data/com.termux/files/usr/bin/mksh
# poor man's method
tr / '\001' | sort "$@" | tr '\001' /
