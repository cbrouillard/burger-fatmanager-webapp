#!/bin/bash
ffmpeg -y -i "$1" -ac 1 -ar 16000 -f s8 -acodec pcm_s8 "$2"
rm "$1" 
