#! /bin/sh

xrdb -merge ~/.Xresources

# Wallpaper
feh --bg-fill --no-fehbg ~/images/wallpaper2.png

# Compositor
picom --config ~/.config/picom/picom.conf

# Task bar
exec ~/.config/polybar/launch.sh

