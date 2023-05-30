#!/bin/bash

src=$1

# Loop through every image in the current directory
count=1
for file in "$src"/*.jpg; do
  # Rename the image with a sequential number padded with zeros
  new_filename=$(printf "%05d.jpg" "$count")
  mv "$file" "$src/$new_filename"
  count=$((count + 1))
done

