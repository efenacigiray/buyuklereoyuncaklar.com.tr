#! /bin/sh

EXTENSIONS="jpe?g"

if [ -z "$1" ]; then
    DIR="`pwd`"
else
    DIR="$1"
fi

# Optimize JPEG images
find "$DIR" -regextype posix-egrep -regex ".*\.($EXTENSIONS)\$" -type f | xargs -I{} jpegtran -optimize -progressive -outfile "{}" "{}"

# Rename xxx.jpg.optimized -> xxx.jpg
#find "$DIR" -name '*.optimized' -print0 | while read -d $'\0' file; do 
#    chown $(stat -c "%U:%G" "${file%.optimized}") "$file"
#    chmod $(stat -c "%a" "${file%.optimized}") "$file"
#    mv -f "$file" "${file%.optimized}"; 
#done
