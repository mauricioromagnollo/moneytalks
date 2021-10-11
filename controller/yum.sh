#!/bin/bash

source "../helpers/colorprint.sh"

alias YUM_UPDATE="sudo yum update"
alias YUM_UPGRADE="sudo yum upgrade -y"

function yum-groupinstall-packages() {
  local packages=( $@ )
  for package in "${packages[@]}"; do
    yum groupinstall $package -y
  done
}

function install-yum-package() {
	local pack="$1"
	colorprint -green "[*] Installing $pack..."
	sudo yum install $pack -y
}

function install-yum-packages() {
  local packages=( $@ )
	for package in "${packages[@]}"; do 
		install-yum-package $package
	done  
}

function remove-yum-package() {
  local pack="$1"
  colorprint -red "[!] Removing $pack..."
  sudo yum remove -y $pack
}

function remove-yum-packages() {
  local packages=( $@ )
  for package in "${packages[@]}"; do
    remove-yum-package $package
  done
}