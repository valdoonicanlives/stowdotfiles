#! /bin/sh

while true 
do
    xsetroot -name  "$(date +"%a %b %d %H:%M")"
    sleep 1s
done &
exec dwm
sleep 1s
exit
