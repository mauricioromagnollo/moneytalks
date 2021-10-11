#!/bin/bash

sudo pacman -Syyuu --noconfirm
sudo pamac upgrade -a
sudo pacman -S base-devel pacman-contrib yay --noconfirm
sudo pacman -R midori parole --noconfirm

