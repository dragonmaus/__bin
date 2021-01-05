set -- "$1" "$2.a" "$3"

home="$(cd "$(dirname "$0")" && env - PATH="$PATH" pwd)"

redo-ifchange "$2.list"

deps=
objs=
while IFS= read -r obj
do
    deps="$deps $obj.deps"
    objs="$objs $obj"
done < "$2.list"

redo-ifchange $objs $deps

cat $deps \
| sed -En 's;/inc/(.+)\.h$;/lib/lib\1.a;p' \
| grep -Fvx "$home/lib/$2" \
| sort -u > "$3"
