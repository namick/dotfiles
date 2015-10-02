#!/bin/bash
# vim: set noexpandtab tabstop=4 shiftwidth=0:
set -e -u

if [[ -d ${DOTFILES_PATH}/vim/bundle/ctrlp-cmatcher ]]; then
	echo "Compiling C ext for ctrlp-cmatcher"
	pushd ${DOTFILES_PATH}/vim/bundle/ctrlp-cmatcher
	./install.sh
	popd
fi
