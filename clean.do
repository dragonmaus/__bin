redo-always
redo-ifchange src/clean

find . -type f '(' -perm -01 -o -perm -010 -o -perm -0100 ')' \
| sed -n 's;^\./;;p' \
| grep -Fv / \
| xargs -r rm -fv 1>&2
