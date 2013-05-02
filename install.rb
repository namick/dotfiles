#!/usr/bin/env ruby
require 'fileutils'

working_dir = File.expand_path(File.dirname(__FILE__))
home_dir = File.expand_path("~")
dot_files = Dir.glob(File.join(working_dir,"*"))

dot_files.each do |filename|
  next if filename =~ /symlink\.rb$/
  next if filename =~ /README\.md$/

  sym_link = File.join(home_dir,".#{File.basename(filename)}")

  FileUtils.rm sym_link if File.symlink?(sym_link) || File.exist?(sym_link)
  FileUtils.ln_s filename,sym_link
end

`git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle`
`vim -u ~/.vimrc.bundles +BundleInstall +qa`
