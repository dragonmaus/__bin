redo-ifchange .gitignore "$PWD.list"

xargs -r redo-ifchange < "$PWD.list"
