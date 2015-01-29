#!/bin/bash

ruby symlink.rb

rm -rf ~/.vim/bundle
mkdir ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qall
