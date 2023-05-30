#!/bin/bash

# Check if the source directory exists
if [ ! -d "$1" ]; then
  echo "Source directory does not exist"
  exit 1
fi

# Create the destination directory if it doesn't exist
mkdir -p "$2"

number=$3

# Loop through every 4th image in the current directory
count=0
for file in "$1"/*.jpg; do
  if [ $((count % $number)) -eq 0 ]; then
    # Copy the image to the preserved_images directory
    cp "$file" "$2"/
  fi
  count=$((count + 1))
done
