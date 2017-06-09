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

find "$dir_in" -iname "*.avi" -o -iname "*.mp4" | while read line
do
	echo "$line"
	output=`echo "$line" | sed -e "s|$dir_in|$dir_out|"` 
	output="${output::-4}.avi"			# always set output format to avi, because avi supports lossless, raw video
	folder=`dirname "$output"`
	#echo "$folder"
	mkdir -p "$folder"
	#ffmpeg -i "$line" -filter:v "crop=min(in_w\,in_h*4/3):min(in_h\,in_w*3/4)" -c:v rawvideo "$output" < /dev/null &> /dev/null
	#ffmpeg -i "$line" -filter:v "boxblur=2:1,crop=min(in_w\,in_h*4/3):min(in_h\,in_w*3/4),scale=16:12:flags=area,noise=alls=20:allf=a" -c:v ffvhuff "$output" < /dev/null &> /dev/null
	ffmpeg -i "$line" -filter:v "boxblur=2:1,crop=min(in_w\,in_h*4/3):min(in_h\,in_w*3/4),scale=16:12:flags=area" -c:v ffvhuff "$output" < /dev/null &> /dev/null
	# always use ffmpeg with null input. It will interfere.
done

