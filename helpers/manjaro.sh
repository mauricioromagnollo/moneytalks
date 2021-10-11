#!/bin/bash

function enable-snap-package() {
	sudo pacman -S snapd --noconfirm
	sudo systemctl enable --now snapd.socket
}

sudo systemctl enable fstrim.timer
sudo systemctl enable sshd.service
sudo systemctl start sshd.service