#!/bin/bash

fps=29

function flow {
    video_path=$1
    result_path=$2
    frame_mod=$3

    base_dir=tmp
    work_dir="$base_dir/$(date +%s)"
    input="$work_dir/input"
    filtered="$work_dir/filtered"
    upscaled="$work_dir/upscaled"
    vid="$work_dir/video.mp4"

    echo "///////////////////////// create folders $work_dir"
    mkdir -p "$input" "$filtered" "$upscaled"

    echo "/////////////////////////  split video into frames"
    ffmpeg -i "$video_path" "$input"/%05d.jpg

    echo "///////////////////////// filter frames"
    ./filter.sh "$input" "$filtered" "$frame_mod"
    ./rename.sh "$filtered"

    echo "///////////////////////// upscale frames"

    # make it usable on windows, but ffmpeg should be in the path
    esrgan=$(find . -maxdepth 1 -name "realesrgan-ncnn-vulkan*" -type f -perm +111 | head -n 1)

    if [[ -z $exec_command ]]; then
        echo "esrgan executable not found"
    fi

    $esrgan \
        -i "$filtered" \
        -o "$upscaled" \
        -n realesrgan-x4plus \
        -s 1 \
        -f jpg
    # cp "$filtered"/* "$upscaled"/

    # TODO: SC2012 (info): Use find instead of ls to better handle non-alphanumeric filenames.
    num_input=$(ls -1 "$input" | wc -l | awk '{$1=$1};1')
    num_filtered=$(ls -1 "$filtered" | wc -l | awk '{$1=$1};1')
    new_fps=$(echo "scale=2; $num_filtered * $fps / $num_input" | bc)
    echo "///////////////////////// fps is $new_fps"

    echo "///////////////////////// create video at $vid"
    ./makevid.sh "$upscaled" "$vid" "$new_fps"

    echo "///////////////////////// motion interpolation"
    ./motioninterpolate.sh "$vid" "$result_path"

    # rm -rf "$work_dir"
}

in_file=$1
out_file=$2
mod=$3


flow "$in_file" "$out_file" "$mod"
