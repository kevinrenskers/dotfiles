#!/bin/bash
cd "$(dirname "$0")"
git pull
function doIt() {
	rsync --exclude "fonts/" --exclude ".osx" --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" --exclude "INSTALL.md" --exclude "agnostic.png" -av --no-perms . ~
	rsync --exclude ".DS_Store" -av --no-perms fonts/ ~/Library/Fonts/
	echo "!!! Start a new terminal session !!!"
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
