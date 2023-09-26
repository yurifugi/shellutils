#!/bin/bash
# Name: video2gif.sh
# Purpose: Convert video to gif in good quality 
# Author: nixCraft {www.cyberciti.biz} under GPL v2.x+
# Syntax: ./script in.mp4 output.gif
#         ./script input.mov
# --------------------------------------------------------
 
# input and output files
in="${1?:Must provide input file. Bye}"
out="${2:-/tmp/out.gif}"
 
# Create a temp png file
png="$(mktemp --suffix=.png)"
 
# Basic failsafe here
[ ! -f "$in" ]  && { echo "Error: $in not found"; exit 1; }
 
# ----------------------------------------------------------------
# Let us do it (read `man ffmpeg` to understand all options)
#
# fps == 10
# scale == 300 
# ----------------------------------------------------------------
ffmpeg -y -i "$in" -vf fps=10,scale=300:-1:flags=lanczos,palettegen "$png"
ffmpeg -y -i "$in" -i "$png" -filter_complex "fps=10,scale=300:-1:flags=lanczos[x];[x][1:v]paletteuse" "$out" && echo -e "*** Wrote '$out' ***\n\n$(ls -lh "$out")\n"
 
[ -f "$png" ] && rm -f "$png"
