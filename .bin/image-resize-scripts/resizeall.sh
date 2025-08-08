#!/bin/bash

# Create the 'resized' directory if it doesn't exist
mkdir -p resized

# Resize all .jpg files in the current directory and save to 'resized/' folder
for img in *.jpg; do
    if [[ -f "$img" ]]; then
        echo "Resizing $img to 1000x1000 and saving to resized/$img..."
        magick "$img" -resize 1000x1000 "resized/$img"
    fi
done

echo "All .jpg images resized and saved in the 'resized' directory."
