#!/bin/bash

FOLDER_NAME=$(pwd | awk -F "/" '{print $NF}')
FILE_NAME=$FOLDER_NAME.ods
find . | sort -V |grep -E -v  "srt|vtt" | tee "$FILE_NAME"