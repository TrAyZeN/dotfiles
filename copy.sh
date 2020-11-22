#!/bin/bash

mkdir -p \
    .config \
    .config/i3 \
    .config/neofetch \
    .config/picom \
    .config/polybar \
    .config/rofi \
    .config/scripts \
    .config/alacritty \
    .icons/default

dot_files=(
.vimrc
.Xresources
.bashrc
.zshrc
.aliasrc
.config/i3/config
.config/neofetch/config.conf
.config/picom/picom.conf
.config/polybar/config
.config/polybar/launch.sh
.config/rofi/config.rasi
.config/rofi/trayzen.rasi
.config/scripts/startup.sh
.config/alacritty/alacritty.yml
.icons/default/index.theme
)

for df in ${dot_files[@]}; do
    cp ~/${df} ./${df} 2> /dev/null
done

