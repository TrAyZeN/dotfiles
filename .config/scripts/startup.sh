#! /bin/sh

xrdb -merge ~/.Xresources

# Wallpaper
feh --bg-fill --no-fehbg ~/images/wallpaper.png

# Task bar
exec ~/.config/polybar/launch.sh

# Compositor
picom --config ~/.config/picom/picom.conf

