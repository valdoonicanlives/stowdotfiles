#!/usr/bin/env sh
# Script for opening a file, intended for use by a terminal file manager.like YAZI

function help_exit() {
    echo "Utility for opening different filetypes.

Usage:
  $ opener [-n {num}] {file} # Open the file in the current shell
  $ opener [-n {num}] detatch {file} # Detatch the program into a new shell

[num]: which opener to use, in order of precedence. defaults to 1
"
    exit 0
}

num=1
[ "$1" = "-n" ] && num=$2 && shift 2

# Whether to open in a new window
detatch=0
[ "$1" = "detatch" ] && detatch=1 && shift 1

list=0
[ "$1" = "list" ] && list=1 && shift 1

# First arg must be a file
file="$1"
[ ! -f "$file" ] && echo "Not a file: '$file'" && help_exit
while [ -L "$file" ]; do
    # Resolve symlinks
    file=$(readlink "$file")
done

function list_exit() {
    [ "$list" -ne 1 ] && return
    i=1
    for arg in "$@"; do
        echo "$i: $arg"
        i=$((i + 1))
    done
    exit 0
}

function launch_gui() {
    if [ "$detatch" -eq 0 ]; then
        [ -n "$WAYLAND_DISPLAY" ] \
            && precmd="swallow" `# For Hyprland` \
            || precmd="devour"   # For X
    else
        precmd="setsid -f"
    fi

    $precmd "$@" >/dev/null 2>&1
}

function launch_term() {
    if [ "$detatch" -eq 1 ]; then
        # This is a bit of a hack.  Shell only expects a single argument into
        # the -c flag, so it needs to be wrapped in quotes.  However, if "$@"
        # wher passed in with `mpv "my file.mp3"`, it would not preserve the
        # $2 having a space and would instead split it up into 3 arguments
        # into the new shell.  Wrapping everything argument in quotes is the
        # only general solution I could come up with.
        command_string=""
        while [ $# -gt 0 ]; do
            command_string="$command_string \"$1\""
            shift
        done
        setsid -f $TERMINAL -e $SHELL -c "$command_string; exec $SHELL" >/dev/null 2>&1
    else
        clear
        "$@"
    fi
}

case $(file --mime-type "$file" -b) in
    application/javascript|\
    application/json|\
	application/pgp-encrypted|\
    application/x-subrip|\
    inode/x-empty|\
    text/*)
        list_exit \
            "Neovim" \
            "Emacs GUI" \
            "Emacs TUI"

        if [ "$num" -eq 2 ]; then
            launch_gui emacsclient -c -a emacs "$file"
        elif [ "$num" -eq 3 ]; then
            launch_term emacsclient -nw -a 'emacs -nw' "$file"
        else
            launch_term nvim "$file"
        fi
        ;;
    image/x-xcf)
        list_exit \
            "Gimp"

        launch_gui gimp "$file"
        ;;
    image/*)
        list_exit \
            "nsxiv" \
            "Gimp"

        if [ "$num" -eq 2 ]; then
            launch_gui gimp "$file"
        else
            launch_gui nsxiv "$file"
        fi
        ;;
	video/*) 
        list_exit \
            "MPV"

        launch_gui mpv -quiet "$file"
        ;;
    application/epub*|\
    application/octet-stream|\
    application/pdf|\
    application/postscript|\
    application/vnd.djvu|\
    image/vnd.djvu)
        list_exit \
            "Zathura"

        launch_gui zathura "$file"
        ;;
    audio/*|\
    video/x-ms-asf) 
        list_exit \
            "MPV"

        # If it has an album cover, launch graphical mpv
        [ -z "$(mediainfo "$1" | grep "Cover\s*: Yes")" ] \
            && (launch_term mpv --audio-display=no "$file") \
            || (launch_gui mpv "$file")
        ;;
    application/msword|\
    application/octet-stream|\
    application/vnd.ms-powerpoint|\
    application/vnd.oasis.opendocument.database|\
    application/vnd.oasis.opendocument.formula|\
    application/vnd.oasis.opendocument.graphics|\
    application/vnd.oasis.opendocument.graphics-template|\
    application/vnd.oasis.opendocument.presentation|\
    application/vnd.oasis.opendocument.presentation-template|\
    application/vnd.oasis.opendocument.spreadsheet|\
    application/vnd.oasis.opendocument.spreadsheet-template|\
    application/vnd.oasis.opendocument.text|\
    application/vnd.openxmlformats-officedocument.presentationml.presentation|\
    application/vnd.openxmlformats-officedocument.spreadsheetml.sheet|\
    application/vnd.openxmlformats-officedocument.wordprocessingml.document)
        list_exit \
            "LibreOffice"
        launch_gui libreoffice "$file"
        ;;
    *)
        echo "No program defined for this filetype."
        ;;
esac

exit 0
