#!/bin/bash

for img in "$@"; do
    outfile="$(dirname "$img")/$(basename "$img" | sed 's/\(.*\)\.\(.*\)/\1_half.\2/')"
    convert "$img" -resize 50% "$outfile"
    setsid mirage "$outfile" >/dev/null 2>&1 &
done
