#!/bin/bash

frame_folder=$1
result_path=$2
framerate=$3

vid=$(basename $result_path)


cd "$frame_folder"

ffmpeg  \
    -r "$framerate" \
    -start_number `ls | grep -E '^[0-9]+\.jpg$' | sed 's/\.jpg$//' | sort -n | head -n 1` \
    -i %05d.jpg  \
    "$vid"

cd -

mv "$frame_folder/$vid" "$result_path"
