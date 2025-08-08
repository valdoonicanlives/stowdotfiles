#!/bin/sh

## @file
## @brief Resize an image to a specified value.
##
## Requires:
## yad
## ImageMagick
##

current_dir=$(dirname "$(readlink -f "$0")")

if ! command -v yad > /dev/null
then
	zenity --window-icon=/usr/local/share/pixmaps/geeqie.png --info --title "Geeqie Resize" --text="yad and ImageMagick are required\n\nyad is not installed"
	exit 0
fi

if ! command -v convert > /dev/null
then
	zenity --window-icon=/usr/local/share/pixmaps/geeqie.png --info --title "Geeqie Resize" --text="yad and ImageMagick are required\n\nImageMagick is not installed"
	exit 0
fi

if [ -z "$1" ]
then
	yad --window-icon=/usr/local/share/pixmaps/geeqie.png --geometry=400 --image dialog-warning --title "Geeqie Resize" --button=gtk-ok:0 --text "\nNo input file was given."
	exit 0
fi

basefile=$(basename "$1")
base=${basefile%.*}
ext=${basefile#*.}

default_filename=$(printf %s "/tmp/$base-resized.$ext")
if [ -f "$default_filename" ]
then
	i=1
	while true
	do
		default_filename=$(printf %s%d%s "/tmp/$base-resized-" "$i" ".$ext")
		if [ -f "$default_filename" ]
		then
			i=$(( i + 1 ))
		else
			break
		fi
	done
fi


selection=$(yad --window-icon=/usr/local/share/pixmaps/geeqie.png \
--center                                                          \
--title="Resize $1"                                               \
--button=gtk-help:"$current_dir"/resize-help.sh                   \
--button=gtk-cancel:1                                             \
--button=gtk-ok:0                                                 \
--text="<b>Reduce image size:</b>\n"                              \
--form                                                            \
--field="Required size kB":NUM           '100!1..100000!1!'       \
--field="Tolerance %":NUM                '10!1..100!1!'           \
--field="Max. iterations":NUM            '20!1..100!1!'           \
--field="Copy if unchanged":CHK          'FALSE'                  \
--field="Strip metadata":CHK             'TRUE'                   \
--field="Show computation":CHK           'FALSE'                  \
--field="Open output file in Geeqie":CHK 'FALSE'                  \
--field="":LBL                                                    \
--field="Output file":SFL                                         \
--field="Default: $default_filename":LBL )

if [ -z "$selection" ]
then
	exit 0
fi

size=$(printf %s "$selection" | cut --delimiter="|" --fields=1 -)
tolerance=$(printf %s "$selection" | cut --delimiter="|" --fields=2 -)
iterations=$(printf %s "$selection" | cut --delimiter="|" --fields=3 -)
copy_unchanged=$(printf %s "$selection" | cut --delimiter="|" --fields=4 -)
strip_metadata=$(printf %s "$selection" | cut --delimiter="|" --fields=5 -)
show_computation=$(printf %s "$selection" | cut --delimiter="|" --fields=6 -)
open_geeqie=$(printf %s "$selection" | cut --delimiter="|" --fields=7 -)
file=$(printf %s "$selection" | cut --delimiter="|" --fields=9 -)

if [ -z "$file" ]
then
	new_filename="$default_filename"
else
	if [ -f "$file" ]
	then
		if ! yad --window-icon=/usr/local/share/pixmaps/geeqie.png --geometry=300 --image dialog-warning --title "Geeqie Resize" --text "\nOutput file already exists.\nOverwrite?"
		then
			exit 0
		fi
	fi
	new_filename="$file"
fi

if [ "$copy_unchanged" = "FALSE" ]
then
	copy="n"
else
	copy="y"
fi

if [ "$strip_metadata" = "FALSE" ]
then
	strip="n"
else
	strip="y"
fi

tmp_file=$(mktemp "${TMPDIR:-/tmp}/geeqie.XXXXXXXXXX")

yad --window-icon=/usr/local/share/pixmaps/geeqie.png --geometry=300 --image dialog-information --title "Geeqie Resize" --button=OK:0 --text "Running Downsize...." &
info_id="$!"

result=$("$current_dir"/downsize -s "$size" -t "$tolerance" -m "$iterations" -c "$copy" -S "$strip" "$1" "$new_filename" > "$tmp_file" 2>/dev/null)

if [ "$?" -eq 1 ]
then
	kill "$info_id"
	rm "$tmp_file"

	yad --window-icon=/usr/local/share/pixmaps/geeqie.png --geometry=400 --image dialog-warning --title "Geeqie Resize" --button=gtk-ok:0 --text "Downsize failed.\n\nIf the filetype is not supported by Downsize,\ntry the Export plugin to get a jpeg.\n\nDownsize error message:\n$result"
	exit 0
fi

kill "$info_id"

if [ "$open_geeqie" = "TRUE" ]
then
	geeqie "$new_filename"
fi


if [ "$show_computation" = "TRUE" ]
then
	yad --window-icon=/usr/local/share/pixmaps/geeqie.png --title "Geeqie Resize computation" --text="$new_filename\n\n$(cat "$tmp_file")" --button=gtk-ok:0
fi

rm "$tmp_file"

exit 0

