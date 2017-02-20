# dotfiles

Things I Use	| |
---------|------
OS		 | Arch Linux 
WM		 | BSPWM
Panel	 | tint2
Terminal | Termite

## Table of Contents
- [Introduction](#using-these-dotfiles)
- [Automatic Installation](#install)

## Using these dotfiles
I am using gnu stow to manage my dotfiles

The dotfiles directory should be at ~/dotfiles

Use `stow [directory]` to link dotfiles to the correct location. 
Note: some directories, such as the pacman directory, cannot be stowed into your home foler and be correctly installed

# install.sh
I am currently working on getting this script to correctly backup files and prompt the user for what package groups to install
