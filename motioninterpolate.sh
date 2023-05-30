#!/bin/bash

input=$1
output=$2

# blend can be changed to mci:
# https://stackoverflow.com/questions/63152626/is-it-good-to-use-minterpolate-in-ffmpeg-for-reducing-blurred-frames

ffmpeg -i "$input" \
    -filter:v "minterpolate='mi_mode=blend:mc_mode=aobmc:me_mode=bidir:me=epzs:fps=60'" \
    -r 60 \
    "$output"
