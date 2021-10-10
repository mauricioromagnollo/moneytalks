#!/bin/bash

source "../utils/colorprint.sh"

function install-pacman-package() {
  local package="$1"
  colorprint -green "[*] Installing $package..."
  sudo pacman -S $package --noconfirm
}

function install-pacman-packages() {
  local packages=( $@ )
  for package in "${packages[@]}"
  do
    install-pacman-package $package
  done 
}

function remove-pacman-package() {
  local package="$1"
  colorprint -red "[*] Removing $package..."
  sudo pacman -R $package --noconfirm
}

function remove-pacman-packages() {
  local packages=( $@ )
  for package in "${packages[@]}"
  do
    remove-pacman-package $package
  done 
}