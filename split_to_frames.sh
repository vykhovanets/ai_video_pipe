#!/bin/bash

in_video_path=$1
result_folder=$2

if [ -d $2 ]; then
    echo "/// FOLDER EXISTS -> choose another name for output"
    return
else
    mkdir -p "$2"
fi

ffmpeg -i "$1" "$result_folder"/%05d.jpg

echo "/// DONE"
