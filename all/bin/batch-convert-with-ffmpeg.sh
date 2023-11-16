#!/bin/sh

ext=$1
echo "Converting files to $ext format"
shift
for f in "$@"; do
    ffmpeg -i "$f" "${f%.*}.$ext" > /dev/null
done
