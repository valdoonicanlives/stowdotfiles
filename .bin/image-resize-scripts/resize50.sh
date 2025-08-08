#! /usr/bin/env bash
# also working
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

#==============
# if any files have uppercase extenstion make it lowercase
shopt -s globstar; for f in **/*.JPG; do mv "$f" "${f%.JPG}.jpg";done
mkdir -p optimizedplus
for image in *.jpg
do
  printf "${GREEN}Compressing${NC} ${image}\n"
  convert -resize 50% $image TGA:- | cjpeg -targa > optimizedplus/$image
done
# convert -resize 50% $image TGA:- | cjpeg -quality 80 -targa > optimizedplus/$image

#below 2 lines uncomment if you want the word resizeopti put on front of name
cd $optimizedplus
for f in *.jpg; do mv "$f" "resizeopti-$f"; done
exit
