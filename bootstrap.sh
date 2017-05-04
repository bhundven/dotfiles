#!/bin/bash
# vi: ts=2:sw=2:et:ai

cd "$(dirname "$0")"

git pull

function doIt() {
  rsync --exclude ".git/" --exclude ".gitmodules" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av . ~
  cd ~/.vim/bundle
  git clone https://github.com/tpope/vim-fugitive
  git clone https://github.com/scrooloose/nerdtree
  git clone https://github.com/scrooloose/syntastic
  git clone https://github.com/majutsushi/tagbar
  git clone https://github.com/tomtom/tlib_vim
  git clone https://github.com/MarcWeber/vim-addon-mw-utils
  git clone https://github.com/fatih/vim-go
  git clone https://github.com/honza/vim-snippets
  git clone https://github.com/christoomey/vim-tmux-navigator
  git clone https://github.com/vim-airline/vim-airline
  git clone https://github.com/vim-airline/vim-airline-themes
  git clone https://github.com/Xuyuanp/nerdtree-git-plugin
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi
unset doIt
source ~/.profile
