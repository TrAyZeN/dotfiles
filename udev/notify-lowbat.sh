#!/bin/sh

# To use notify-send as root
# Function taken from: https://stackoverflow.com/a/49533938
function root_notify_send() {
    # Detect the name of the display in use
    local display=":$(ls /tmp/.X11-unix/* | sed 's#/tmp/.X11-unix/X##' | head -n 1)"

    # Detect the user using such display
    local user=$(who | grep '('$display')' | awk '{print $1}' | head -n 1)

    # Detect the id of the user
    local uid=$(id -u $user)

    echo "$display $user $uid"

    sudo -u $user DISPLAY=$display DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus /usr/bin/notify-send "$@"
}

root_notify_send -u critical 'Low battery' '15% battery remaining'
