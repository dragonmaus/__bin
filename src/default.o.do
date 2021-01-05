try() {
    if test -f "$1"
    then
        redo-ifchange "$1.o"
        cp -fp "$1.o" "$2"
        chmod +x "$2"
        return 0
    elif test -f "$1.do"
    then
        redo-ifchange "$1"
        try "$1" "$2"
        return $?
    else
        redo-ifcreate "$1"
        return 1
    fi
}

for e in s c
do
    try "$2.$e" "$3" && exit 0
done

echo "$0: fatal: don't know how to build '$1'" 1>&2
exit 99
