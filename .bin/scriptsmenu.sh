#!/bin/sh

# commented out below line as back on x and tofi is for wayland
#selected=$(ls ~/.config/scriptsmenu/ |tofi)&& bash ~/.config/scriptsmenu/$selected
selected=$(ls ~/.config/scriptsmenu/ |rofi -dmenu -p)&& bash ~/.config/scriptsmenu/$selected

