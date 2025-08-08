#!/bin/bash

killall waybar

riverctl spawn "waybar -c ~/.config/waybar/river/config-river -s ~/.config/waybar/river/river_style.css" &

