set -- "$1" "$2.a" "$3"

home="$(cd "$(dirname "$0")" && env - PATH="$PATH" pwd)"

redo-ifchange "$2.list"
xargs redo-ifchange "$home/bin/archive" < "$2.list"

xargs "$home/bin/archive" cr "$3" < "$2.list"
