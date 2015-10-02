#!/bin/bash
# vim: set noexpandtab tabstop=4 shiftwidth=0:
set -e -u

DOTFILES_PATH=${DOTFILES_PATH:-"$HOME/.dotfiles"}

function create_link() {
	[[ -e "$DOTFILES_PATH/$1" ]] || (echo "Source does not exist"; exit 1)
	echo -n "  ~/$2 : "
	if [[ ! -e "$HOME/$2" ]]; then
		mkdir -p "$(dirname "$HOME/$2")"
		ln -sv "$DOTFILES_PATH/$1" "$HOME/$2"
	else
		echo "already exists"
	fi
}

echo "Installing to $HOME from ${DOTFILES_PATH}..."

create_link 'gitconfig' '.gitconfig'
create_link 'gitignore' '.gitignore'

create_link 'gemrc' '.gemrc'

create_link 'tmux.conf' '.tmux.conf'
create_link 'ackrc' '.ackrc'

create_link 'vimrc' '.vimrc'
mkdir -vp $HOME/.vim/backup
mkdir -vp $HOME/.vim/bundle

if [[ ! -d ${HOME}/.vim/bundle/Vundle.vim ]]; then
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

vim +PluginInstall! +qall

# for bin in bin/*; do
# 	create_link "$bin" ".local/${bin}"
# done
