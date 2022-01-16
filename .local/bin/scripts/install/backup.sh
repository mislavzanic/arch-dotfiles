#!/bin/bash

backup() {
    cd "$1"
    git add .
    git commit -m"backup"
    git push origin master
}

clean_xmonad() {
    cd $HOME/dotfiles/.config/xmonad
    rm -rf .stack-work
    rm -rf mexmonad.cabal
    rm -rf stack.yaml.lock
    rm -rf xmonad.hi xmonad.o
}

backup_sys_dots() {
    git clone git@github.com:mislavzanic/dotfiles.git $HOME/dotfiles
    [ -d "$HOME/.local/bin/scripts" ] && rm -rf $HOME/dotfiles/.local/bin/scripts && cp -r "$HOME/.local/bin/scripts" "$HOME/dotfiles/.local/bin/"
    [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/starship.toml" ] && rm $HOME/dotfiles/.config/starship.toml && cp $HOME/.config/starship.toml $HOME/dotfiles/.config/starship.toml
    for item in doom slock dunst compton shell x11 zsh nvim xmonad alacritty dmenu sxiv; do
        [ -d "${XDG_CONFIG_HOME:-$HOME/.config}/$item" ] &&  rm -rf $HOME/dotfiles/.config/$item && cp -r "${XDG_CONFIG_HOME:-$HOME/.config}/$item" $HOME/dotfiles/.config/
    done
    clean_xmonad
    backup $HOME/dotfiles
    cd $HOME
    rm -rf $HOME/dotfiles
}

main() {
    backup_sys_dots
}

main
