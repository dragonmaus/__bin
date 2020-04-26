redo-always
redo-ifchange src/clean

find . -type f '(' -perm -01 -o -perm -010 -o -perm -0100 ')' \
| sed -n 's;^\./;;p' \
| grep -Fv / \
| xargs rm -fv .gitignore 1>&2
