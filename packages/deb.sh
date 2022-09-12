#!/bin/bash

APT_UPDATE='sudo apt update'
APT_UPGRADE='sudo apt upgrade -y'
APT_AUTOREMOVE='sudo apt autoremove -y'
APT_AUTOCLEAN='sudo apt autoclean'
APT_DIST_UPGRADE='sudo apt dist-upgrade -y'
APT_FULL_UPGRADE='sudo apt full-upgrade -y'
APT_DEPENDENCIES='sudo apt install -f -y'

function install-package() {
  local package="$1"

  if [ ! -z "$package" ]; then
    printc -green "[*] Installing $package..."
    sudo apt install $package -y
  fi
}

function install-packages() {
  local packages=( $@ )

  if [ ! -z "$packages" ]; then
    for package in "${packages[@]}"; do
      install-package $package
    done 
  fi
}

function remove-package() {
  local package="$1"

  if [ ! -z "$package" ]; then
    printc -red "[*] Removing $package..."
    sudo apt remove $package -y
    $APT_AUTOREMOVE
  fi
}

function remove-packages() {
  local packages=( $@ )

  if [ ! -z "$packages" ]; then
    for package in "${packages[@]}"; do
      remove-package $package
    done 
  fi
}

function install-snap-package() {
  local package="$1"

  if [ ! -z "$package" ]; then
    printc -green "[*] Installing $package..."
    sudo snap install $package -y
  fi
}