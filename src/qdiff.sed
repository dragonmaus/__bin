#!/usr/bin/sed -Enf
s;^Files [^/]+/(.+) and [^/]+/(.+) are identical$;same: \1;p
s;^Files [^/]+/(.+) and [^/]+/(.+) differ$;differ: \1;p
s;^Only in ([^/]+)/(.+): ;only \1: \2/;p
s;^Only in ([^/]+): ;only \1: ;p
