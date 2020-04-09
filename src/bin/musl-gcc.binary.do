redo-always
redo-ifchange gcc.binary

readlink -f "$(which musl-gcc)" > "$3"
redo-stamp < "$3"
