!/bin/bash
chmod +x pop-os.sh

sudo apt update
sudo apt full-upgrade -y

function apt-install() {
	sudo apt install -y $1
}

function apt-remove() {
	sudo apt remove -y $1
}

function install-obs-studio() {
	sudo apt install ffmpeg -y
	sudo apt install v4l2loopback-dkms -y
	sudo add-apt-repository ppa:obsproject/obs-studio -y
	sudo apt update
	sudo apt install obs-studio -y
}

function install-beekeeper() {
	wget --quiet -O - https://deb.beekeeperstudio.io/beekeeper.key | sudo apt-key add -
	echo "deb https://deb.beekeeperstudio.io stable main" | sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list
	sudo apt update
	sudo apt install beekeeper-studio -y
}

function install-balena-etcher() {
	curl -1sLf \
   'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' \
   | sudo -E bash

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

function install-visual-sutudio-code() {
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	rm -f packages.microsoft.gpg
	sudo apt install apt-transport-https -y
	sudo apt update
	sudo apt install code -y
}

function mongodb-compass() {
	wget https://downloads.mongodb.com/compass/mongodb-compass_1.26.1_amd64.deb
	sudo dpkg -i mongodb-compass_1.26.1_amd64.deb
}

function install-devdocs() {
	wget https://github.com/egoist/devdocs-desktop/releases/download/v0.7.2/DevDocs_0.7.2_amd64.deb
	sudo dpkg -i DevDocs_0.7.2_amd64.deb && sudo apt install -f -y
}

function install-docker-and-compose() {
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

apt-install plank discord telegram-desktop dbeaver-ce kdenlive transmission simplescreenrecorder
apt-install ubuntu-restricted-extras vlc
apt-install gnome-tweaks
apt-install fonts-firacode

apt-install papirus-icon-theme google-chrome-stable

apt-install git vim

apt-install steam

apt-install spotify-client nautilus-dropbox

sudo ufw enable

sudo apt install -y openvpn

# Remove Packages

sudo apt remove -y geary gnome-contacts

# -----------------------------------

## Java
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 8.0.302-zulu

## ASDF (Node | Yarn)

- npm global install

# Oh My Zsh


# Insomnia
echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list
sudo apt update
sudo apt install insomnia -y

# Spotify (Add key to error)

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -