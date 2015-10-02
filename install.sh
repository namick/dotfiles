#!/bin/bash
# vim: set noexpandtab tabstop=4 shiftwidth=0:
set -e -u

if [[ ${DOTFILES_PATH:-unset} == 'unset' ]]; then
	export DOTFILES_PATH="$HOME/.dotfiles"
fi

if [[ ! -d ${DOTFILES_PATH}/.git ]]; then
	if [[ -d ${DOTFILES_PATH} ]]; then
		echo "$DOTFILES_PATH already exists but isn't a git repo. Unsure how to continue."
		exit 1
	fi

	git clone git@github.com:namick/dotfiles.git "${DOTFILES_PATH}"
fi

cd "${DOTFILES_PATH}"

./link.sh
./setup.sh
