#!/bin/bash

HOST_NAME="notebook-fedora"

# Enable Tap to Click (Mouse)
# Disable Screen Power

sudo dnf update -y

# Multimedia
sudo dnf group upgrade --with-optional Multimedia

# Set Hostname
sudo hostnamectl set-hostname $HOST_NAME

# Enable RPM Fusion
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# Game Setup
sudo dnf install -y wine lutris steam gamemode 

sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda