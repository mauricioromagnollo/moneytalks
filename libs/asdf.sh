#!/bin/bash
# https://asdf-vm.com/

function asdf-setup-vm() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
  echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
  echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc

  if [ -f ~/.zshrc ]; then
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
    echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
  fi
}

function asdf-install() {
  # node.js
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf install nodejs latest
  asdf global nodejs latest

  # python
  asdf plugin-add python
  asdf install python 2.7.13
  asdf install python 3.6.12
  asdf global python 3.6.2 2.7.13

  # postgres
  sudo apt-get install linux-headers-$(uname -r) build-essential libssl-dev libreadline-dev zlib1g-dev libcurl4-openssl-dev uuid-dev -y
  asdf plugin-add postgres

  # kubectl
  asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git
  asdf install kubectl 1.18.17
  asdf global kubectl 1.18.17

  # java
  asdf plugin-add java https://github.com/halcyon/asdf-java.git
  asdf list-all java
  asdf install java latest
  asdf global java latest

  # golang
  asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
  asdf install golang latest
  asdf global golang latest
}