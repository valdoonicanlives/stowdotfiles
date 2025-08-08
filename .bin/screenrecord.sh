#!/bin/bash
# AI google search made this DK
# Define video directory
# install  libxrandr  
VIDDIR="$HOME/Videos/Screencasts"
[ ! -d "$VIDDIR" ] && mkdir "$VIDDIR"

# Get screen resolution
#RES=$(xrandr | grep '\*' | awk '{print $1}')

# Define output filename (e.g., test_recording.mp4)
FILENAME="$1"

# Check if a filename was provided, otherwise default to "recording"
if [ -z "$FILENAME" ]; then
  FILENAME="recording"
fi

# Define the output path
OUTPUT_FILE="$VIDDIR/${FILENAME}.mp4"

# Check if an audio device was provided, otherwise default to pulse
AUDIO_DEVICE="0"
if [ ! -z "$2" ]; then
  AUDIO_DEVICE="$2"
fi

# Run FFmpeg to record the screen
ffmpeg -y -f x11grab -video_size 1280x720 -framerate 30 -i :0.0 -f pulse -ac 2 -i "$AUDIO_DEVICE" -c:v libx264 -pix_fmt yuv420p -s 1280x720 -preset ultrafast -c:a libopus -b:a 128k -threads 0 -strict normal -bufsize 2000k "$OUTPUT_FILE"
