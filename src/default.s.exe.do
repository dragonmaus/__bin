set -- "$1" "$2.s" "$3"

home="$(cd "$(dirname "$0")" && env - PATH="$PATH" pwd)"

redo-ifchange "$2.exe.deps"
xargs redo-ifchange "$home/bin/load" "$home/bin/strip" "$2.o" < "$2.exe.deps"

sed -E < "$2.exe.deps" \
  -e 's;^.*/lib/lib(.+)\.a$;-l\1;' \
  -e '1i\
-Wl,--start-group
' \
  -e '$a\
-Wl,--end-group
' \
| xargs "$home/bin/load" -o "$3" "$2.o" -nostdlib

"$home/bin/strip" "$3"
