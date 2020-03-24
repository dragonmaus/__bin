#!/usr/bin/sed -f

/^+++/ s/^/\x1b[1m/
/^---/ s/^/\x1b[1m/

/^+/ s/^/\x1b[32m/
/^-/ s/^/\x1b[31m/
/^@/ s/^/\x1b[36m/

/^Binary files .* are identical$/ s/^/\x1b[1m/
/^Files .* are identical$/ s/^/\x1b[1m/

/^\\/ s/^/\x1b[35m/

/^diff / s/^/\x1b[1m/

t end
s/^[^	 ]/\x1b[1m&/
: end

s/ \{1,\}$/\x1b[1;30m&/

: loop
s/ \( *\)$/+\1/
t loop

s/$/\x1b[m/
