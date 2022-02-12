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

mv_config() {
    cfg=($(ls "$HOME/dotfiles/$1"))
    [ -f "$HOME/$1" ] || mkdir "$HOME/$1"
    for item in "${cfg[@]}"; do
        mv $item $HOME/$1/
    done
}


dot_dirs=$(parse_yaml ".dirs[]" 'config.yaml')
for dir in $dot_dirs; do
    [ -d "$HOME/$dir" ] || mkdir -p "$HOME/$dir"
    mv_config "$dir"
done

wm=$(parse_yaml '.wm' 'config.yaml')
[ "$wm" == 'xmonad' ] && install_xmonad
[ "$wm" == 'qtile' ] && install_qtile
