#!/data/data/com.termux/files/usr/bin/sed -Ef
s;^Files [^/]+/(.+) and [^/]+/(.+) are identical$;same: \1;
s;^Files [^/]+/(.+) and [^/]+/(.+) differ$;differ: \1;
s;^Only in ([^/]+)/(.+): ;only \1: \2/;
s;^Only in ([^/]+): ;only \1: ;
