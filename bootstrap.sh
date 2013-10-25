#!/bin/bash
cd "$(dirname "$0")"
git pull
git submodule init
git submodule update
cd repo-mm; git submodule init && git submodule update; cd ..
function doIt() {
	rsync --exclude ".git/" --exclude ".gitmodules" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av . ~
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
