#!/bin/bash

cp /usr/share/X11/xorg.conf.d/40-libinput.conf ./40-libinput.conf
cp ~/.config/alacritty/alacritty.yml ./alacritty.yml
cp ~/.config/bpytop/bpytop.conf ./bpytop.conf
cp ~/.config/cava/config ./cava.config
cp ~/.config/i3/config ./i3-gaps.config
cp ~/.config/nvim/init.vim ./init.vim
cp ~/.config/picom.conf ./picom.conf
cp ~/.config/gtk-3.0/settings.ini ./settings.ini
cp ~/.vimrc ./vimrc
cp ~/.tmux.conf ./.tmux.conf
cp ~/.zshrc ./.zshrc

rm -r ./polybar && mkdir polybar
cp -r ~/.config/polybar/forest ./polybar
cp -r ~/.config/polybar/cuts ./polybar

rm -f ./Backgrounds/*
cp -r ~/OSsetup/Backgrounds/* ./Backgrounds/
