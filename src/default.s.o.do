set -- "$1" "$2.s" "$3"

home="$(cd "$(dirname "$0")" && env - PATH="$PATH" pwd)"

redo-ifchange "$2.o.deps"
xargs redo-ifchange "$home/bin/assemble" "$2" < "$2.o.deps"

"$home/bin/assemble" -o "$3" "$2"
