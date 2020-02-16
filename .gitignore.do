redo-ifchange "$2.def" "$PWD.list" src/git-ignore.exe

sed 's;^;/;' < "$PWD.list" | cat "$2.def" - > "$3"
src/git-ignore.exe -f "$3" '' 2> /dev/null # enforce correct sorting
