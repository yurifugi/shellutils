#!/usr/bin/env bash

if [ ! $# -ge 1 ]
then
    echo "Usage: $0 \"filename.[avi,mkv]\"
    # echo "Usage: $0 \"filename.[avi,mkv]\" \"/destination/folder/\""
    exit 1
fi

CONTINUE="n"
while [ "$CONTINUE" != "y" ] 
do
    clear
    echo "######## $0"
    echo
    echo "Destination will be: 'conv-$1'."
    echo "Origin is '$1'."
    echo 
    echo "Listing Video Streams from '$1'"
    echo
    ffprobe -i "$1" -hide_banner 2>&1 | grep -i "video" | nl -v0
    echo
    echo "Video Track is? (zero based)> "
    read -r videoTrack
    echo
    echo "Video Track will be:"
    ffprobe \
        -hide_banner \
        -v error \
        -select_streams v:"$videoTrack" \
        -show_entries stream \
        "$1" 2>&1 | grep -i -e language -e codec_name -e codec_type -e duration
    echo
    echo "Ok? <y>"
    read -n1 CONTINUE        
done



CONTINUE="n"
while [ "$CONTINUE" != "y" ] 
do
    clear
    echo "######## $0"
    echo
    echo "Destination will be: 'conv-$1'."
    echo "Origin is '$1'."
    echo 
    echo "Listing Audio Streams from '$1'"
    echo
    ffprobe -i "$1" -hide_banner 2>&1 | grep -i "audio" | nl -v0
    echo
    echo "Audio Track is? (zero based)> "
    read -r audioTrack
    echo
    echo "Audio Track will be:"
    ffprobe \
        -hide_banner \
        -v error \
        -select_streams a:"$audioTrack" \
        -show_entries stream \
        "$1" | grep -i -e language -e codec_name -e codec_type -e duration
    echo
    echo "Ok? <y>"
    read -n1 CONTINUE        
done


CONTINUE="n"
while [ "$CONTINUE" != "y" ] 
do
    clear
    echo "######## $0"
    echo
    echo "Destination will be: 'conv-$1'."
    echo "Origin is '$1'."
    echo 
    echo "Listing Subtitle Streams (and its titles) from '$1'"
    echo
    ffprobe -i "$1" -hide_banner 2>&1 | grep -iE "subtitle|title" | nl -v0 -bpStream
    echo
    echo "Subtitle Track is? (zero based)> "
    read -r subTrack
    echo
    echo "Subtitle Track will be:"
    ffprobe \
        -hide_banner \
        -v error \
        -select_streams s:"$subTrack" \
        -show_entries stream \
        "$1" | grep -i -e language -e title
    echo
    echo "Ok? <y>"
    read -n1 CONTINUE        
done

if [[ ${#videoTrack} -gt 0 ]] && [[ ${#audioTrack} -gt 0 ]] && [[ ${#subTrack} -gt 0 ]]
then
        ffmpeg -i "$1" \
        -hide_banner \
        -map 0:a:"$audioTrack" \
        -map 0:s:"$subTrack" \
        -map 0:v:"$videoTrack" \
        -c:v copy \
        -c:a ac3 \
        -c:s copy "conv-$1"
        RETVAL="$?"
        
        chmod a+w -Rv "conv-$1"

else
    echo
    echo "Something went wrong." 
    echo "videoTrack: '$videoTrack'."
    echo "audioTrack: '$audioTrack'."
    echo "subTrack: '$subTrack'."

fi

if [[ $RETVAL = "0" ]]
then 
    echo "ffmpeg RETVAL = 0"
    echo "Delete origin? <y,n>"
    read -n1 DELORIGIN
    if [[ $DELORIGIN = "y" ]]
    then
        rm -fv "$1"
    fi
else
    echo "ffmpeg !RETVAL = 0"
    echo "something went wrong."
fi