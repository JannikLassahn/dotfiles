#!/bin/bash

dir = ~./dotfiles

# Remove existing files
sudo rm -rf ~/.tmux.conf > /dev/null 2>&1
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.p10k.zsh > /dev/null 2>&1

# Symlink new files
ln -sf $dir/tmux/tmux.conf ~/.tmux.conf
ln -sf $dir/zsh/.zshrc ~/.zshrc
ln -sf $dir/zsh/.p10k.zsh ~/.p10k.zsh

sudo chsh -s /bin/zsh
