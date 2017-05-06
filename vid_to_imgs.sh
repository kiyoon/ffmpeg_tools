#!/bin/bash

# Author: Kiyoon Kim (yoonkr33@gmail.com)
# Description: find all videos and make the directories of the names, and in the directory, extract all the frames into image files.

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
	folder=`echo $line | sed -e "s|$dir_in|$dir_out|" | sed -e 's/\.[^.]*$//'`
	#echo "$folder"
	mkdir -p "$folder"
	#ffmpeg -i "$line" -qscale:v 2 "$folder/%05d.jpg" < /dev/null &> /dev/null
	ffmpeg -i "$line" "$folder/%05d.bmp" < /dev/null &> /dev/null
	# always use ffmpeg with null input. It will interfere.
done

