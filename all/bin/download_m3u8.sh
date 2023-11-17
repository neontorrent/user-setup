#!/usr/bin/env bash

echo "'${2:-video}.mp4'"

if [ -n "$(which ffmpeg)" ]; then
    FFMPEG=ffmpeg
elif [ -n "$(which ffmpeg.exe)" ]; then
    FFMPEG=ffmpeg.exe
fi

if [ -n "$FFMPEG" ]; then
    $FFMPEG -protocol_whitelist file,http,https,tcp,tls,crypto -i "$1" -c copy -f mp4 "${2:-video}.mp4"
else
    echo "No ffmpeg executable found"
fi
