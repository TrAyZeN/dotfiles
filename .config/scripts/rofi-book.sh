#!/bin/sh

rofi \
    -modi "book:~/.config/rofi/scripts/book.sh" \
    -show book \
    -matching fuzzy \
    -no-cycle
