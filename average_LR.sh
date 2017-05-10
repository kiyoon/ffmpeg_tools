#!/bin/bash

# Author: Kiyoon Kim (yoonkr33@gmail.com)
# Description: find all videos and set the resolution to 16x12 (averagin area) by first cropping and then scaling them.

if [ $# -lt 2 ]
then
	echo "usage: $0 [dir_in] [dir_out]"
	exit 0
fi

dir_in=$(realpath $1)
dir_out=$(realpath $2)
find "$dir_in" -iname "*.avi" -o -iname "*.mp4" | while read line
do
	echo "$line"
	output=`echo "$line" | sed -e "s|$dir_in|$dir_out|"` 
	output="${output::-4}.avi"			# always set output format to avi, because avi supports lossless, raw video
	folder=`dirname "$output"`
	#echo "$folder"
	mkdir -p "$folder"
	ffmpeg -i "$line" -filter:v "crop=in_h*4/3:in_h,scale=16:12:flags=area" -c:v rawvideo "$output" < /dev/null &> /dev/null
	# always use ffmpeg with null input. It will interfere.
done

