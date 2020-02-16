redo-always

find . -type f \
  '(' -perm -01 -o -perm -010 -o -perm -0100 ')' \
  -o -name '*.binary' \
  -o -name '*.format' \
  -o -name '*.specs' \
  -o -name '*.wrapper' \
| sed -n 's;^\./;;p' \
| sort -u \
| xargs -r rm -fv 1>&2
