set -- "$1" "$2.s" "$3"

home="$(cd "$(dirname "$0")" && env - PATH="$PATH" pwd)"

redo-ifchange "$2"

sed -En "s;^[	 ]*%[	 ]*include[	 ]+'(.+)'.*$;$home/inc/\\1;p" < "$2" \
| sort -u > "$3"
