#!/bin/sh

set -e

. echo.sh

prompt=$(echo $1)
shift

temp=$(mktemp -d)
chmod 0700 $temp

pipe=$temp/pipe
rm -fr $pipe
mkfifo -m 0600 $pipe
sed -n 's/^D //p' < $pipe &
exec > $pipe
rm -f $pipe
rm -fr $temp

exec pinentry-smart << END
OPTION lc-ctype=${LC_ALL:-${LC_CTYPE:-${LANG:-C}}}
OPTION ttyname=$(tty)
OPTION ttytype=$TERM
SETDESC $*
SETPROMPT ${prompt:-Password:}
GETPIN
END
