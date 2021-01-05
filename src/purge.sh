#!/bin/sh

for d
do
    find "$d" -type f -exec shred -uvz {} +
    [[ -e "$d" ]] || continue
    find "$d" -depth -exec sh -c '
        for p do
            p=$(realpath "$p")
            d=$(dirname "$p")
            o=$(basename "$p")
            n=$(echo "$o" | sed s/./0/g)
            mv -fv "$d/$o" "$d/$n"
            fsync "$d/$n"
            while [[ ${#n} -gt 1 ]]
            do
                o=$n
                n=${o%0}
                mv -fv "$d/$o" "$d/$n"
                fsync "$d/$n"
            done
            rm -dfv "$d/$n"
        done
    ' sh {} +
done
