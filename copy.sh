#!/bin/bash

dot_files=(
.vimrc
.Xresources
.bashrc
.zshrc
.aliasrc
.config/mimeapps.list
.config/i3/config
.config/nvim/init.vim
.config/nvim/coc-settings.json
.config/neofetch/config.conf
.config/picom/picom.conf
.config/polybar/config
.config/polybar/launch.sh
.config/rofi/config.rasi
.config/rofi/trayzen.rasi
.config/scripts/startup.sh
.config/alacritty/alacritty.yml
.icons/default/index.theme
.config/gtk-3.0/settings.ini
)

for df in ${dot_files[@]}; do
    mkdir -p "$(dirname ${df})"
    cp ~/${df} ./${df} 2> /dev/null
done

