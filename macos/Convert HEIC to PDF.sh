#!/bin/sh

for f in "$@"
do
	EXT="${f##*.}"
	FN="${f%.*}"
	EXT_UC=$(tr '[a-z]' '[A-Z]' <<< $EXT)
	if [ "HEIC" = "$EXT_UC" ]; then
		sips -s format jpeg "$f" --out "$FN.jpg"
		sips -s format pdf "$FN.jpg" --out "$FN.pdf"
		rm "$FN.jpg"
	fi
done
