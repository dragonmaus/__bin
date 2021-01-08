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
for f
do
    echo "#	$f"
done

echo '#'

mkdirs() {
    d=$(dirname "$1")
    [[ "$d" = . || "$d" = / ]] && return
    echo "mkdir -p '$d' > /dev/null 2>&1"
}

for f
do
    [[ -e "$f" ]] || die 1 "$0: '$f': No such file or directory"

    l=$(echo "$f" | tr "'" _)
    q=$(echo "$f" | sed "s/'/'\\\\''/g")

    if [[ -h "$f" ]]
    then
        t="$(readlink "$f" | sed "s/'/'\\\\''/g")"
        echo "echo c - '$q'"
        mkdirs "$q"
        echo "ln -s '$t' '$q'"
    elif [[ -d "$f" ]]
    then
        echo "echo c - '$q'"
        echo "mkdir -p '$q' > /dev/null 2>&1"
    elif [[ -f "$f" ]]
    then
        echo "echo x - '$q'"
        mkdirs "$q"
        echo "sed 's/^X//' > '$q' << 'END-of-$l'"
        sed 's/^/X/' < "$f"
        echo "END-of-$l"
    else
        warn "$0: Unsupported file type: '$f'"
    fi
done

echo exit
echo
