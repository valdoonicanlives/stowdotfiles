## Bspwm
#export BSPWM_SOCKET="/tmp/bspwm-socket"
XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME

# so that you don't have to type startx to log in when not using a display manager
if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep bspwm || startx "/home/delboy/.xinitrc"
#	pgrep Hyprland || Hyprland
fi

eval "$(gh completion -s zsh)"
