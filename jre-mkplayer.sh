#!/usr/bin/env bash

# jre-mkplayer.sh
# Generate a htm file with the Spotify player for the JRE episode 
# You must pass the episode id during command execution

# set -x

SHOWURL="https://open.spotify.com/show/4rOoJ6Egrf8K2IrywzwOMk"
TMPFILE=$(mktemp) || exit 1

echo 
echo "Getting past JRE episodes..."
curl "$SHOWURL" --output "$TMPFILE" --silent
xmllint --nowarning --html "$TMPFILE" 2>/dev/null  |grep  -E 'track-name|tracklist-row' |head -20 | grep -oE 'href.*|\#.*' | cut -d\< -f1
rm -f "$TMPFILE"
printf "\n\nEpisode id?"
read -r "EPISODEID" 

PLAYERFILE="$EPISODEID.htm"

HTML="<p><iframe src=\"https://open.spotify.com/embed-podcast/episode/$EPISODEID\" width=\"1080\" height=\"2160\" frameborder=\"0\" allowtransparency=\"true\" allow=\"encrypted-media\"></iframe></p>"
echo "$HTML" > "$PLAYERFILE"

echo "File generated:"
echo "$PWD/$PLAYERFILE"
