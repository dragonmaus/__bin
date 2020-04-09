redo-always

readlink -f "$(which nasm)" > "$3"
redo-stamp < "$3"
