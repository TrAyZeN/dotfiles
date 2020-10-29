#!/bin/bash

mkdir -p .config
mkdir -p .config/i3
mkdir -p .config/neofetch
mkdir -p .config/compton
mkdir -p .config/polybar
mkdir -p .config/rofi
mkdir -p .config/scripts

dot_files=(
.vimrc
.Xresources
.bashrc
.zshrc
.config/i3/config
.config/neofetch/config.conf
.config/compton/compton.conf
.config/polybar/config
.config/polybar/launch.sh
.config/rofi/config.rasi
.config/rofi/trayzen.rasi
.config/scripts/startup.sh
)

for df in ${dot_files[@]}; do
    cp ~/${df} ./${df}
done

