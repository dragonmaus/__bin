#!/bin/sh

set -e

. echo.sh

[[ $# -eq 0 ]] && die 1 "Usage: $0 file [file...]"

cat << END
# This is a shell archive. Save it in a file, remove anything before
# this line, and then unpack it by entering "sh file". Note, it may
# create directories; files and directories will be owned by you and
# have default permissions.
#
# This archive contains:
#
END
for f do
    echo "#	$f"
done

echo '#'

mkdirs() {
    d=$(dirname "$1")
    [[ "$d" = . || "$d" = / ]] && return
    echo "mkdir -p '$d'"
}

for f do
    q=$(echo "$f" | sed "s/'/'\\\\''/g")
    echo "echo x - '$q'"
    if [[ -f "$f" ]]
    then
        mkdirs "$q"
        echo "sed 's/^X//' > '$q' << 'END-of-$q'"
        sed 's/^/X/' < "$f"
        echo "END-of-$q"
    elif [[ -h "$f" ]]
    then
        mkdirs "$q"
        t="$(readlink "$f" | sed "s/'/'\\\\''/g")"
        echo "ln -s '$t' '$q'"
    elif [[ -d "$f" ]]
    then
        echo "mkdir -p '$q'"
    else
        warn "$0: Unsupported file type: '$f'"
    fi
done

echo exit
echo
