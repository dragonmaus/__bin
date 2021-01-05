#!/bin/sed -Ef
s;^(Binary f|F)iles /?[^/]+/(.+) and /?[^/]+/(.+) are identical$;same: \2;
s;^(Binary f|F)iles /?[^/]+/(.+) and /?[^/]+/(.+) differ$;differ: \2;
s;^Only in (/?[^/]+)/(.+): ;only \1: \2/;
s;^Only in (/?[^/]+): ;only \1: ;
