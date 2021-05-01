#!/usr/bin/env bash

pen="/mnt/pen"

# Listing streams
for i in *.mkv;
do
    printf "\n MKV: %s\n" "$i"
    ffmpeg -i "$i" -f null 2>&1 | grep -iE "stream||title"
done

# Converts audio track to ac3
# Copy only the specified subtitle and video tracks

printf "\nVideo Track is? (zero based)"
read -r videoTrack
printf "\nAudio Track is? (zero based)"
read -r audioTrack
printf "\nSubtitle Track is? (zero based)"
read -r subTrack

for i in *.mkv;
do
    echo "MKV: $i"
    ffmpeg -i "$i" \
        -map 0:a:"$audioTrack" \
        -map 0:s:"$subTrack" \
        -map 0:v:"$videoTrack" \
        -c:v copy \
        -c:a ac3 \
        -c:s copy "$pen/$i"
done