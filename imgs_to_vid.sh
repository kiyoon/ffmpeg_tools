#!/bin/bash

# Author: Kiyoon Kim (yoonkr33@gmail.com)
# Description: make a video file from image files.

if [ $# -lt 2 ]
then
	echo "Usage: $0 [directory_containing_images] [output avi name]"
	echo "Should be format of %05d.bmp"
	exit 0
fi

realdir=$(realpath "$1")
#dirname=$(dirname "$realdir")
#dirbase=$(basename "$realdir")

# vcodec = rawvideo or huffyuv(lossless compression)
ffmpeg -i "$realdir/%05d.bmp" -vcodec rawvideo "$2" < /dev/null &> /dev/null
