#!/data/data/com.termux/files/usr/bin/mksh

. echo.sh

L=0
d=0
l=0
s=0
while getopts :Ldls opt
do
    case $opt in
    (L)
        L=1
        s=0
        ;;
    (d)
        d=1
        ;;
    (l)
        l=1
        ;;
    (s)
        L=0
        s=1
        ;;
    (*)
        exit 1
        ;;
    esac
done
shift $((OPTIND - 1))

[[ $L -eq 1 ]] && l=0

cd "$(xdg-user-dir BACKGROUNDS)"

desktop=$(head -1 < .current-desktop)
lockscreen=
[[ $L -eq 1 ]] && lockscreen=$(head -1 < .current-lockscreen)

find * -type f 2> /dev/null | grep -Fvx -e "$desktop" -e "$lockscreen" | shuf | head -2 | (
    IFS= read -r desktop
    IFS= read -r lockscreen

    echo "$desktop" > .current-desktop{new}
    mv -f .current-desktop{new} .current-desktop

    if [[ $L -eq 0 ]]
    then
        [[ $s -eq 1 ]] && lockscreen=$desktop
        echo "$lockscreen" > .current-lockscreen{new}
        mv -f .current-lockscreen{new} .current-lockscreen
    fi
)

if [[ $d -eq 1 ]]
then
    set-desktop "$(head -1 < .current-desktop)"
fi
if [[ $l -eq 1 ]]
then
    set-lockscreen "$(head -1 < .current-lockscreen)"
fi
