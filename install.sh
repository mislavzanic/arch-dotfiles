#!/bin/bash

install_xmonad() {
    cd $HOME/.config/xmonad
    chmod a+x build && ./build
}


mv_config() {
    cfg=($(ls "$HOME/dotfiles/$1"))
    [ -f "$HOME/$1" ] || mkdir "$HOME/$1"
    for item in "${cfg[@]}"; do
        mv $item $HOME/$1/
    done
}


[-f $HOME/.local] || mkdir $HOME/.local
mv_config ".config"
mv_config ".local/bin"
mv_config ".local/share"
install_xmonad
