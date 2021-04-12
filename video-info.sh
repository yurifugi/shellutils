#!/usr/bin/env bash

# set -x 

trap 'rm -f "$TMPFILE"' EXIT
trap 'rm -f "$INFOFILE"' EXIT


HOURNOW=$(date +%H%M%S)
TMPFILE=$(mktemp) || exit 1
INFOFILE=$(mktemp) || exit 1


echo "Extracting info from $1"

ffprobe -v error \
    -show_format \
    -of json=compact=1 \
    -pretty \
    "$1" > "$TMPFILE"

jq  '.format.filename, .format.format_long_name, .format.duration, .format.bit_rate | select( . != null )' "$TMPFILE" > "$INFOFILE"


ffprobe -v error \
    -select_streams v \
    -show_entries stream=codec_type,codec_name,codec_long_name \
    -of json=compact=1 \
    -pretty \
    "$1" > "$TMPFILE"

jq  '.streams[].codec_type, .streams[].codec_name, .streams[].codec_long_name | select( . != null )' "$TMPFILE" >> "$INFOFILE"


ffprobe -v error \
    -select_streams a \
    -show_entries stream=codec_type,codec_name,codec_long_name \
    -of json=compact=1 \
    -pretty \
    "$1" > "$TMPFILE"

jq  '.streams[].codec_type, .streams[].codec_name, .streams[].codec_long_name | select( . != null )' "$TMPFILE" >> "$INFOFILE"

echo "Filename; File Format; Duration; Bit Rate; Stream; Codec; Codec Long Name; Stream; Codec; Codec Long Name"
echo
paste -s -d ";" "$INFOFILE"
echo
 
rm -f "$TMPFILE"
rm -f "$INFOFILE"
