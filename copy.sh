#!/bin/bash

dot_files=(
.vimrc
.Xresources
.bashrc
.zshrc
.aliasrc
.gtkrc-2.0
.gitconfig
.tmux.conf
.config/mimeapps.list
.config/i3/config
.config/nvim/init.vim
.config/nvim/coc-settings.json
.config/nvim/lua/user/keymap.lua
.config/nvim/lua/user/plugins.lua
.config/nvim/lua/user/settings.lua
.config/neofetch/config.conf
.config/picom/picom.conf
.config/polybar/config
.config/polybar/launch.sh
.config/rofi/config.rasi
.config/rofi/keys.rasi
.config/rofi/trayzen.rasi
.config/rofi/scripts/book.sh
.config/scripts/startup.sh
.config/scripts/rofi-book.sh
.config/alacritty/alacritty.yml
.config/kitty/kitty.conf
.icons/default/index.theme
.config/gtk-3.0/settings.ini
.config/openbox/autostart
.config/openbox/environment
.config/openbox/menu.xml
.config/openbox/rc.xml
.config/feh/buttons
.config/mpd/mpd.conf
.config/ncmpcpp/config
.config/ncmpcpp/bindings
)

for df in ${dot_files[@]}; do
    mkdir -p "$(dirname ${df})"
    cp ~/${df} ./${df} 2> /dev/null
done

cp /etc/udev/notify-lowbat.sh ./udev/notify-lowbat.sh
cp /etc/udev/rules.d/99-notify-lowbat.rules ./udev/rules.d/99-notify-lowbat.rules
