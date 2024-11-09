#!/usr/bin/env bash

appname="notify_brightness"
# Arbitrary but unique message tag
msgTag="brightness"

brightness="$(light | sed 's/\.[0-9]+$//g')"

# Show the volume notification
dunstify -a "$appname" -u low -i audio-volume-high -t 2000 \
    -h string:x-dunst-stack-tag:$msgTag -h int:value:"$brightness" "Brightness: ${brightness}%"
