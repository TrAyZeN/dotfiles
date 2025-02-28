#!/bin/sh

# -modes "book:~/.config/rofi/scripts/book.sh,book-full:~/.config/rofi/scripts/book-full.sh" \

rofi \
    -modes "book:~/.config/rofi/scripts/book.sh" \
    -show book \
    -matching fuzzy \
    -sort \
    -no-cycle
