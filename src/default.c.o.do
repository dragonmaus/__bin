set -- "$1" "$2.c" "$3"

home="$(cd "$(dirname "$0")" && env - PATH="$PATH" pwd)"

redo-ifchange "$2.o.deps"
xargs redo-ifchange "$home/bin/compile" "$2" < "$2.o.deps"

"$home/bin/compile" -o "$3" "$2"
