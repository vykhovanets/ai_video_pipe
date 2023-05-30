#!/bin/bash

in_folder=$1
out_folder=$2
mod=$3

mkdir -p "$out_folder"

for in_file in "$in_folder"/*; do
  out_file="$out_folder/$(basename "$in_file")"
  echo $in_file
  echo $out_file

  echo ./flow.sh "$in_file" "$out_file" "$mod"

  ./flow.sh "$in_file" "$out_file" "$mod"
done
