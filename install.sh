#!/bin/sh

ruby symlink.rb

rm -rf ~/.vim/bundle
mkdir ~/.vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim -u ~/.vimrc.bundles +BundleInstall +qa
