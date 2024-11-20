#!/usr/bin/env bash

INPUT_FILE="$1"

echo "Video format converter:"
echo "From: any format;"
echo "To:   x265."
echo "Usage:"
echo "  video2x265.sh <video-input.mp4>"

echo "Using file: ${INPUT_FILE}."
echo "File is: $(file ${INPUT_FILE})"

FILENAME="${INPUT_FILE%.*}"
EXTENSION="${INPUT_FILE##*.}"
OUTPUT_FILE="${FILENAME}-x265.mp4"

# echo "DEBUG: FILENAME: $FILENAME"
# echo "DEBUG: EXTENSION: $EXTENSION"
# echo "DEBUG: OUTPUT_FILE: $OUTPUT_FILE"

echo "Press <ENTER> to continue. <CTRL+C> to abort."
read


ffmpeg -i "$INPUT_FILE" -vcodec libx265 -crf 28 "$OUTPUT_FILE"
CONV_RESULT="$?"

echo "Conversion finished with return value: ${CONV_RESULT}."
echo "Input file:  ${INPUT_FILE}."
echo "Output file: ${OUTPUT_FILE}."
