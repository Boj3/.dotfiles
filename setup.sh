#!/bin/bash
git clone https://github.com/Boj3/.dotfiles.git
rm ~/.bashrc
cd ~/.dotfiles
stow alacritty
stow tmux
stow bashrc
stow bat
stow zsh
stow dunst
stow picom
stow polybar
stow rofi
stow bspwm
stow sxhkd
