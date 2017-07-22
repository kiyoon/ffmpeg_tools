#!/bin/bash

# Author: Kiyoon Kim (yoonkr33@gmail.com)
# Description: find all videos and set the resolution to 16x12 (averagin area) by first cropping and then scaling them.

if [ $# -lt 2 ]
then
	echo "usage: $0 [dir_in] [dir_out]"
	exit 0
fi

# readlink -f : make absolute path, file must exist
# readlink -m : files doesn't have to exist

dir_in=$(readlink -f $1)
dir_out=$(readlink -m $2)

find "$dir_in" -iname "*.avi" | while read line
do
	echo "$line"
	output=`echo "$line" | sed -e "s|$dir_in|$dir_out|"` 
	output="${output::-4}.mp4"
	folder=`dirname "$output"`
	#echo "$folder"
	mkdir -p "$folder"
	ffmpeg -i "$line" -c:v libx264 -crf 19 -preset slow -c:a copy "$output" < /dev/null &> /dev/null
	# always use ffmpeg with null input. It will interfere.
done

