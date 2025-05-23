#!/bin/sh

BOOK_DIR="$HOME/books"

if [ -z "${ROFI_OUTSIDE}" ]
then
    echo "Run this script inside rofi" 1>&2
    exit
fi

if [ -n "${ROFI_INFO}" ]; then
    CURR_PWD="${ROFI_INFO}"
else
    CURR_PWD="${BOOK_DIR}"
fi

if [ -d "${CURR_PWD}" ]; then
    ls -1 "${CURR_PWD}" | while read file; do
        echo -en "${file}\x00info\x1f${CURR_PWD}/${file}\n"
    done
else
    xdg-open "${CURR_PWD}" >/dev/null 2>&1
    exit 0
fi
