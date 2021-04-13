#!/usr/bin/env bash

# jre-mkplayer.sh
# Generate a htm file with the Spotify player for the JRE episode 
# You must pass the episode id during command execution

# set -x

SHOWURL="https://open.spotify.com/show/4rOoJ6Egrf8K2IrywzwOMk"
TMPFILE=$(mktemp) || exit 1

if [ "$1" = "" ]
then
    echo "Must provide episode id."
    echo "Example: $ jre-mkplayer.sh 3Atye1uCqaW2Ver3d16wJO"
    echo "Show: $SHOWURL"
    echo "Ep: https://open.spotify.com/episode/3Atye1uCqaW2Ver3d16wJO"
    echo "                                     ^--------------------^ < This is episode id"
    echo 
    echo "Getting past episodes..."
    curl "$SHOWURL" --output "$TMPFILE" --silent
    xmllint --nowarning --html "$TMPFILE" 2>/dev/null  |grep  -E 'track-name|tracklist-row' |head -20 | grep -oE 'href.*|\#.*' | cut -d\< -f1
    rm -f "$TMPFILE"
    exit 1
fi


HTML="<p><iframe src=\"https://open.spotify.com/embed-podcast/episode/$1\" width=\"1080\" height=\"2160\" frameborder=\"0\" allowtransparency=\"true\" allow=\"encrypted-media\"></iframe></p>"
echo "$HTML" > "$1".htm

# echo "param1=$1"
# echo "HTML=$HTML"
# cat "$1".htm