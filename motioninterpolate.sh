#!/bin/bash

input=$1
output=$2

# blend can be changed to mci:
# https://stackoverflow.com/questions/63152626/is-it-good-to-use-minterpolate-in-ffmpeg-for-reducing-blurred-frames

ffmpeg -i "$input" \
    -filter:v "minterpolate='mi_mode=blend:fps=29'" \
    -r 29 \
    "$output"
