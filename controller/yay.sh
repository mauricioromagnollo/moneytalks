#!/bin/bash

source "../utils/colorprint.sh"

function install-yay-package() {
  local package="$1"
  colorprint -green "[*] Installing $package..."
  yay -S $package --noconfirm
}

function install-yay-packages() {
  local packages=( $@ )
  for package in "${packages[@]}"
  do
    install-yay-packages $package
  done 
}