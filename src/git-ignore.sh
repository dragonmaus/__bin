#!/bin/sh

set -e

. echo.sh

find_gitignore() (
  while :
  do
    if [[ -d .git || -f .gitignore ]]
    then
      echo "$(env - PATH="$PATH" pwd)/.gitignore"
      return 0
    fi
    [[ . -ef .. ]] && return 1
    cd ..
  done
)

name=$(basename "$0" .sh)
usage="Usage: $name [-glh] [-f FILE] pattern [pattern...]"
help="$usage

  -f FILE  operate on FILE
  -g       operate on \"global\" file (\$GIT_WORK_TREE/.gitignore)
  -l       operate on \"local\" file (\$PWD/.gitignore) [default]
  -h       display this help"

file=
while getopts :f:h opt
do
  case $opt in
  (f)
    file=$OPTARG
    ;;
  (g)
    file=$(find_gitignore) || die 1 "$name: Not inside a git repository"
    ;;
  (h)
    die 0 "$help"
    ;;
  (l)
    file=
    ;;
  (:)
    warn "$name: Option '$OPTARG' requires an argument"
    die 100 "$usage"
    ;;
  (\?)
    warn "$name: Unknown option '$OPTARG'"
    die 100 "$usage"
    ;;
  esac
done
shift $((OPTIND - 1))

if [[ -z "$file" ]]
then
  file=$(env - PATH="$PATH" pwd)/.gitignore
fi

[[ -e "$file" ]] || touch "$file"

which pathsort > /dev/null 2>&1 && sort=pathsort || sort=sort

rm -f "$file{tmp}"
for line
do
  echo "$line"
done | cat "$file" - | $sort -u | grep . > "$file{tmp}"

rm -f "$file{new}"
{
  grep -v '^!' < "$file{tmp}" || :
  grep '^!' < "$file{tmp}" || :
} > "$file{new}"
rm -f "$file{tmp}"

warn -n "Updating $file... "
if cmp -s "$file" "$file{new}"
then
  warn 'Nothing to do!'
else
  mv -f "$file{new}" "$file"
  warn 'Done!'
fi
rm -f "$file{new}"
