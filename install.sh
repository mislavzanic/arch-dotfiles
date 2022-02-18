#!/bin/bash

parse_yaml() {
    result=($(yq "$1" "$2" | sed 's/\"//g' | tr '\n' ' '))
    echo "${result[@]}"
}

install_qtile() {
    sudo pacman -S qtile
}

install_xmonad() {
    cd $HOME/.config/xmonad
    chmod a+x build && ./build
}

link_files() {
    dot_dirs=$(parse_yaml ".symlink.$1[]" "$HOME/.config/.dotfiles/config.yaml")
    for dir in $dot_dirs; do
        [ -d "$HOME/.$1/$dir" ] && rm -rf "$HOME/.$1/$dir"
        ln -sf "$HOME/.config/.dotfiles/.$1/$dir" "$HOME/.$1/$dir"
    done
}

link_files 'config'
link_files 'local'
#wm=$(parse_yaml '.wm' 'config.yaml')
#[ "$wm" == 'xmonad' ] && install_xmonad
#[ "$wm" == 'qtile' ] && install_qtile
