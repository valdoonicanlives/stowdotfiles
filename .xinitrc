#!/bin/env zsh
###!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
# Kill any dangling shell sessions from prior xsessions
#commented out below for now as tryign zsh again
#. $HOME/bin/colr
#killall bash

xrandr --dpi 96
xsetroot -cursor_name left_ptr &
# X11 display managers usually start pulseaudio.. but we're using tiling window managers :-)
#pulseaudio --start
#use hsetroot to set backgrnd color as xsetroot is over-written by compton if using it.
hsetroot -solid "#393939"
#below to solve backlight problem
#xbacklight -inc 80 
#GPG_TTY=$(tty)
#export GPG_TTY
#eval $(gpg-agent --daemon)
export DE=gnome
#below allows you to leave the X system back to the console with ctrl-alt-backspace
#setxkbmap -option terminate:ctrl_alt_bksp
#set keyboard layout
setxkbmap -layout gb
#xmodmap .Xmodmap &&
#export WIDTH=$(xwininfo -root | awk '/Width/{ print $2 }')
#export HEIGHT=$(xwininfo -root | awk '/Height/{ print $2 }')
#==========
#for Bspwm
#PANEL_FIFO=/tmp/panel-fifo
#PANEL_HEIGHT=18
#PANEL_FONT_FAMILY="-*-terminus-medium-r-normal-*-12-*-*-*-c-*-*-1"
#export PANEL_FIFO PANEL_HEIGHT PANEL_FONT_FAMILY
#=============
# got below from this thread
# https://bbs.archlinux.org/viewtopic.php?id=56646&p=6
#/home/dka/bin/wm-chooser
# Start your window manager using xinit, (xinit wm eg xinit i3)
#/home/dka/bin/wm-chooser
sxhkd &  
polybar -c /home/delboy/.config/polybar/config &
#
#/home/delboy/.bin/start-bspwm &

DEFAULTSESSION=/home/delboy/.bin/start-bspwm

case "$1" in
        "cwm")
		exec /home/dka/bin/cwm-startapps &
                exec /home/dka/bin/cwm
                ;;
        "monster")
                exec monsterwm
                ;;
        "spectrwm")
                exec spectrwm
                ;;
        "2bwm")
                exec 2bwm
                ;;
        *)
                exec $DEFAULTSESSION
                ;;
esac

