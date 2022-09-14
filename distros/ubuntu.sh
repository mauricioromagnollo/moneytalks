#!/bin/bash
chmod +x ubuntu.sh

# /boot/efi - FAT32 - 512mb



# =======================================
function main() {
  # Set true if you will install in your personal computer
  local PERSONAL_INSTALLATION=false

  # First Ubuntu Settings
  $APT_UPDATE
  $APT_UPGRADE
  sudo ubuntu-drivers autoinstall
  install-package "ubuntu-restricted-extras"

  # Install Utils Packages
  local UTILS_PACKAGES=("gnome-screenshot" "simplescreenrecorder" "xinput" "gnome-tweaks" "vlc" "google-chrome-stable")
  install-packages ${UTILS_PACKAGES[@]}

  # Install Fonts
  local FONTS_PACKAGES=("fonts-firacode")
  install-packages ${FONTS_PACKAGES[@]}

  # Install Development Packages
  local DEV_PACKAGES=("git" "vim" "build-essential" "openvpn" "curl" "default-jdk" "fontconfig")
  install-packages ${DEV_PACKAGES[@]}

  # Install Icons, Theme and Docky (Plank)
  local ICONS_THEME_PACKAGES=("papirus-icon-theme" "plank")
  install-packages ${ICONS_THEME_PACKAGES[@]}

  # Setup File .gitconfig
  setup-git-config

  # Add New Terminal Commands
  # setup-new-terminal-commands

  # Install Useful Programs
  install-visual-studio-code
  install-docker
  install-snap-package "dbeaver-ce"
  install-insomnia
  install-spotify
  # install-zsh-powerlevel10k

  # ASDF and Languages
  asdf-setup-vm
  
  

  # terraform

  if $PERSONAL_INSTALLATION; then
    install-obs-studio
    install-package "inkscape"
    install-package "kdenlive"
    install-package "telegram-desktop"
    install-package "discord"
    install-package "steam"
    install-package "transmission"
    install-package "nautilus-dropbox"
    install-package "virtualbox"
    install-razer-settings-mannager
    # install-balena-etcher
    # install-mongodb-compass
    # install-devdocs
  else
    install-zoom
    install-snap-package "slack"
  fi

  # Enable Firewall
  sudo ufw enable
}
# =======================================


# =======================================
# PROGRAMS AND PACKAGES
# =======================================
function install-visual-studio-code() {
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  sudo apt install apt-transport-https -y
  sudo apt update
  sudo apt install code -y  
}

function install-razer-settings-mannager() {
  sudo apt install software-properties-gtk -y
  sudo add-apt-repository ppa:openrazer/stable -y
  sudo apt update
  sudo apt install openrazer-meta -y
  sudo gpasswd -a $USER plugdev
  sudo add-apt-repository ppa:polychromatic/stable -y
  sudo apt update
  sudo apt install polychromatic -y
}

function install-docker() {
  # Install docker
  sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  sudo apt install docker-ce docker-ce-cli containerd.io -y
  # Add docker to group to run without sudo
  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker
  # Install docker-compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

function install-obs-studio() {
  sudo apt install ffmpeg -y
  sudo apt install v4l2loopback-dkms -y
  sudo add-apt-repository ppa:obsproject/obs-studio -y
  sudo apt update
  sudo apt install obs-studio -y
}

function install-spotify() {
  curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update && sudo apt-get install spotify-client -y
}

function install-zoom() {
  wget https://zoom.us/client/5.11.10.4400/zoom_amd64.deb
  printc -green "[*] Installing Zoom..."
  sudo apt install ./zoom_amd64.deb
  $APT_DEPENDENCIES
  rm ./zoom_amd64.deb
}

function install-insomnia() {
  # Add to sources
  echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list

  # Refresh repository sources and install Insomnia
  sudo apt update
  install-package "insomnia"
}

function install-pritunl() {
  sudo tee /etc/apt/sources.list.d/pritunl.list << EOF
deb https://repo.pritunl.com/stable/apt jammy main
EOF

  sudo apt --assume-yes install gnupg
  gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A
  gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A | sudo tee /etc/apt/trusted.gpg.d/pritunl.asc
  sudo apt update
  sudo apt install pritunl-client-electron -y
}

# =======================================
# PROGRAMS AND PACKAGES
# =======================================

# =======================================
main
# =======================================

:<<'SCML'
function install-dropbox() {

}

function install-insync() {

}

function install-mega() {
  
}

function install-balena-etcher() {
	curl -1sLf \
   'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' \
   | sudo -E bash

}

function mongodb-compass() {
	wget https://downloads.mongodb.com/compass/mongodb-compass_1.26.1_amd64.deb
	sudo dpkg -i mongodb-compass_1.26.1_amd64.deb
}

function install-devdocs() {
	wget https://github.com/egoist/devdocs-desktop/releases/download/v0.7.2/DevDocs_0.7.2_amd64.deb
	sudo dpkg -i DevDocs_0.7.2_amd64.deb && sudo apt install -f -y
}
SCML