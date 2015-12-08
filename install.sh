#!/bin/bash
set -e -u

apt-get update && apt-get install -y git

export DOTFILES_PATH=${DOTFILES_PATH:-"${HOME}/.dotfiles"}

git clone https://github.com/namick/dotfiles.git $DOTFILES_PATH

cd $DOTFILES_PATH

./link.sh
./setup.sh
