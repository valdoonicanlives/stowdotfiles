#!/usr/bin/env bash

folder=/home/delboy/notes

newnote () { \
  name="$(echo "" | tofi -c -p "Enter a name: " <&-)" || exit 0
  : "${name:=$(date +%F_%T | tr ':' '-')}"
  setsid -f "$TERMINAL" -e nvim $folder$name".md" >/dev/null 2>&1
}

selected () { \
  choice=$(echo -e "New\n$(command ls -t1 $folder)" | tofi -c -l 5 -i -p "Choose note or create new: ")
  case $choice in
    New) newnote ;;
    *.md) setsid -f "$TERMINAL" -e nvim "$folder$choice" >/dev/null 2>&1 ;;
    *) exit ;;
  esac
}

selected
