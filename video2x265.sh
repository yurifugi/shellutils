#!/usr/bin/env bash

echo "Video format converter:"
echo "From: any format;"
echo "To:   x265."
echo "Usage:"
echo "  video2x265.sh <video-input.mp4>"
echo "Press <ENTER> to continue. <CTRL+C> to abort."

ffmpeg -i "$1" -vcodec libx265 -crf 28 "r-${1}"