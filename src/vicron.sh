#!/bin/sh

set -e

. echo.sh

uid=$(id -u)

case $uid in
(0)
    crontab=/etc/crontab
    ;;
(*)
    crontab=~/etc/crontab
    ;;
esac

rm -f $crontab{tmp}
cp -p $crontab $crontab{tmp}

${EDITOR:-vi} $crontab{tmp}

fsync $crontab{tmp} || :

if cmp -s $crontab{tmp} $crontab
then
    echo vicron: $crontab unchanged
    rm -f $crontab{tmp}
else
    mv -f $crontab{tmp} $crontab
    pkill -x -u $uid -HUP scrond
fi
