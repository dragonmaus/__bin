#!/data/data/com.termux/files/usr/bin/mksh
termux-dialog -p -t "${1:-Password:}" | jq -j .text
