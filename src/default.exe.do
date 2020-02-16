try() {
  if test -f "$1"
  then
    redo-ifchange "$1.exe"
    cp -fp "$1.exe" "$2"
    chmod +x "$2"
    return 0
  else
    redo-ifcreate "$1"
    return 1
  fi
}

for e in s c sh py calc sed
do
  try "$2.$e" "$3" && exit 0
done

echo "$0: fatal: don't know how to build '$1'" 1>&2
exit 99
