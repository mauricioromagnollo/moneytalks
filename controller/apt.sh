#!/bin/bash

source "../helpers/colorprint.sh"

alias APT_UPDATE="sudo apt update"
alias APT_UPGRADE="sudo apt upgrade -y"
alias APT_AUTOREMOVE="sudo apt autoremove -y"
alias APT_AUTOCLEAN="sudo apt autoclean"
alias APT_DIST_UPGRADE="sudo apt dist-upgrade -y"
alias APT_FULL_UPGRADE="sudo apt full-upgrade -y"
alias APT_DEPENDENCIES="sudo apt install -f -y"

function install-pacman-package() {
  local package="$1"
  colorprint -green "[*] Installing $package..."
  sudo apt install $package -y
}

function install-apt-packages() {
  local packages=( $@ )
  for package in "${packages[@]}"
  do
    install-apt-package $package
  done 
}

function remove-apt-package() {
  local package="$1"
  colorprint -red "[*] Removing $package..."
  sudo apt remove $package -y
  APT_AUTOREMOVE 
}

function remove-apt-packages() {
  local packages=( $@ )
  for package in "${packages[@]}"
  do
    remove-apt-package $package
  done 
}