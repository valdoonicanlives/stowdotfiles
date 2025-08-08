#!/bin/bash

menu=("awesome
bash
dmenu
dunst
dwm
i3
kitty
lf
neovim
profile
qtile
sfm
slock
spectrwm
st
vim
vifm
xinitrc
Xresources
xprofile
zsh
quit")

choice="$(echo -e "${menu[@]}" | dmenu -l 10 -p "Edit File: ")"

case "$choice" in
    quit)
        echo "program terminated." && exit 0
        ;;
    awesome)
        choice="$HOME/.config/awesome/rc.lua"
        ;;
    bash)
       [ -f "$HOME/.bashrc" ] && choice="$HOME/.bashrc" || \
       [ -f "$HOME/.config/bash/.bashrc" ] && choice="$HOME/.config/bash/.bashrc"
        ;;
    dmenu)
        choice="$HOME/.local/src/suckless/dmenu/config.def.h"
        ;;
    dunst)
        choice="$HOME/.config/dunst/dunstrc"
        ;;
    dwm)
        choice="$HOME/.local/src/suckless/dwm/config.def.h"
        ;;
    i3)
        choice="$HOME/.config/i3/config"
        ;;
    kitty)
        choice="$HOME/.config/kitty/kitty.conf"
        ;;
    lf)
        choice="$HOME/.config/lf/lfrc"
        ;;
    neovim)
        choice="$HOME/.config/nvim/init.vim"
        ;;
    profile)
        choice="$HOME/.profile"
        ;;
    qtile)
        choice="$HOME/.config/qtile/config.py"
        ;;
    sfm)
        choice="$HOME/.local/src/suckless/sfm/config.def.h"
        ;;
    slock)
        choice="$HOME/.local/src/suckless/slock/config.def.h"
        ;;
    spectrwm)
        choice="$HOME/.config/spectrwm/spectrwm.conf"
        ;;
    st)
        choice="$HOME/.local/src/suckless/st/config.def.h"
        ;;
    vim)
        choice="$HOME/.config/vim/vimrc"
        ;;
    vifm)
        choice="$HOME/.config/vifm/vifmrc"
        ;;
    xinitrc)
        choice="$HOME/.xinitrc"
        ;;
    Xresources)
        [ -f "$HOME/.config/x11/.Xresources" ] && choice="$HOME/.config/x11/.Xresources" || \
        choice="$HOME/.Xresouces"
         ;;
    xprofile)
        [ -f "$HOME/.config/x11/xprofile" ] && choice="$HOME/.config/x11/xprofile" || \
        choice="$HOME/.xprofile"
        ;;
    zsh)
        [ -f "$HOME/.config/zsh/.zshrc" ] && choice="$HOME/.config/zsh/.zshrc" || \
        choice="$HOME/.zshrc"
        ;;
    *)
        exit 1
        ;;

esac

st -e $EDITOR "$choice"

