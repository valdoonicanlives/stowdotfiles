#!/bin/bash
# name of this script is screencast.sh
#This is the ffmpeg command that the screencast shortcut in i3 will run, or use keybinding app.
cd /home/dka/Videos/Screencasts/
#Picks a file name for the output file based on availability:

if [[ -f ~/screencast.mkv ]]
	then
		n=1
		while [[ -f ~/screencast_$n.mkv ]]
		do	
			n=$((n+1))
		done
		filename="screencast_$n.mkv"
		echo $n
	else
		filename="screencast.mkv"
fi

#The actual ffmpeg command:

ffmpeg -y \
-f x11grab \
-s $(xdpyinfo | grep dimensions | awk '{print $2;}') \
-i :0.0 \
 -f alsa -i default \
 -c:v ffvhuff -r 25 -c:a flac $filename
