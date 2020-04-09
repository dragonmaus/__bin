redo-always
redo-ifchange clang.binary

readlink -f "$(which musl-clang)" > "$3"
redo-stamp < "$3"
