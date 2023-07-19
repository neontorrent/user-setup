#!/bin/bash

ffmpeg -i "$1" -filter_complex "[0:a]silencedetect=n=-90dB:d=0.3[outa]" -map '[outa]' -f s16le -y /dev/null 2>&1 | F='-aq 70 -v warning' perl -ne 'INIT { $ss=0; $se=0; } if (/silence_start: (\S+)/) { $ss=$1; $ctr+=1; printf "ffmpeg -nostdin -i '"$1"' -ss %f -t %f $ENV{F} -y %03d.mp3\n", $se, ($ss-$se), $ctr; }  if (/silence_end: (\S+)/) { $se=$1; } END { printf "ffmpeg -nostdin -i '"$1"' -c copy -ss %f $ENV{F} -y %03d.mp3\n", $se, $ctr+1; }' | bash -x
