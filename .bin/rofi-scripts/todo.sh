#!/bin/bash
# simple todo list
NOTES_FILE=~/.rofinotes/rofi_todo

if [[ ! -a "${NOTES_FILE}" ]]; then
    echo "empty" >> "${NOTES_FILE}"
fi

function get_notes()
{
    cat ${NOTES_FILE}
}

ALL_NOTES="$(get_notes)"

NOTE=$( (echo "${ALL_NOTES}")  | rofi -dmenu -p "Type-Note-to-add:")
MATCHING=$( (echo "${ALL_NOTES}") | grep "^${NOTE}$")

if [[ -n "${MATCHING}" ]]; then
    NEW_NOTES=$( (echo "${ALL_NOTES}")  | grep -v "^${NOTE}$" )
else
    NEW_NOTES=$( (echo -e "${ALL_NOTES}\n${NOTE}") | grep -v "^$")
fi

echo "${NEW_NOTES}" > "${NOTES_FILE}"
