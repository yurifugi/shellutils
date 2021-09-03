#!/usr/bin/env bash

MEDIAMNT=$(lsblk -f -o NAME,MOUNTPOINT -l |grep media)

echo "Device    MountPoint"
echo "$MEDIAMNT"

ls -la $(echo "$MEDIAMNT" | awk '{ print $2 }')

printf "\nDestination: (/some/folder/)> "
read -r DEST


# Listing streams
ffmpeg -i "$1" -f null 2>&1 | grep -iE "stream||title"


# Converts audio track to ac3
# Copy only the specified subtitle and video tracks

printf "\nVideo Track is? (zero based)> "
read -r videoTrack
printf "\nAudio Track is? (zero based)> "
read -r audioTrack
printf "\nSubtitle Track is? (zero based)> "
read -r subTrack

printf "\nVideo:\n"
ffprobe \
    -hide_banner \
    -v panic \
    -select_streams v:"$videoTrack" \
    -show_entries stream \
    "$1" | grep lang

printf "\nAudio:\n"
ffprobe \
    -hide_banner \
    -v panic \
    -select_streams a:"$audioTrack" \
    -show_entries stream \
    "$1" | grep lang

printf "\nSubtitle:\n"
ffprobe \
    -loglevel error \
    -select_streams s:24 \
    -show_entries stream=index:stream_tags=language,title \
    -of csv=p=0 \
    "$1"

printf "n\All's good? <y/n>"
read CONTINUE

if [[ $CONTINUE == "y" ]]
then 
    ffmpeg -i "$1" \
        -map 0:a:"$audioTrack" \
        -map 0:s:"$subTrack" \
        -map 0:v:"$videoTrack" \
        -c:v copy \
        -c:a ac3 \
        -c:s copy "$DEST/$1"
fi
