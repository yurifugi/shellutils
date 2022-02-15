#!/usr/bin/env bash

IMG_EXT=(jpg jpeg pnd webp)

for EXTENSION in "${IMG_EXT[@]}"
do
    for FILE in *."$EXTENSION"
    do
        MD5NAME=$(md5sum "$FILE" | awk '{ print $1 }')
        mv -fv "$FILE" "$MD5NAME"."$EXTENSION"

    done
done