#!/bin/sh

echo() {
  print -R "$@"
}

(
  echo '#include <sys/syscall.h>'
  for name do
    echo "SYS_$name \"$name\""
  done
) | tcc -E - | grep '^[^#_]' | sort -n
