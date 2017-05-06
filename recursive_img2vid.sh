#!/bin/bash

# Author: Kiyoon Kim (yoonkr33@gmail.com)
# Description: find all directory containing 00001.bmp file and make the directories to video files

if [ $# -lt 2 ]
then
	echo "Usage: $0 [input_dir] [output_dir]"
	exit 0
fi

input_dir=$(realpath $1)
output_dir=$(realpath $2)

bmps=$(find "$input_dir" -name "00001.bmp")
total=$(echo "$bmps" | wc -l)
i=0
echo "$bmps" | while read bmpfile 
do
	((i++))
	dirname=$(dirname "$bmpfile")
	outname=$(echo "$dirname" | sed -e "s|^$input_dir|$output_dir|" | sed -e 's/$/.avi/')
	mkdir -p "$(dirname "$outname")"
	echo "$dirname to $outname..($i/$total)"
	bash imgs_to_vid.sh "$dirname" "$outname"
done

