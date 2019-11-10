#!/bin/bash
###############################################################################
#         Name: init.sh
#        Usage: ./init.sh
#
#  Description: Simple script to autocreate the symlinks for my dotfiles and
#               copy some helper programs to /usr/local/bin
#
# Last Updated: Sun 27 Oct 2019 07:12:10 PM CDT
#
#    Tested on: Ubuntu 18.04 Bionic Beaver
#
#   Maintainer: Jose Elera (https://github.com/jelera)
#
#      License: MIT
#               Copyright (c) 2019 Jose Elera
#
#               Permission is hereby granted, free of charge, to any person
#               obtaining a copy of this software and associated documentation
#               files (the "Software"), to deal in the Software without
#               restriction, including without limitation the rights to use,
#               copy, modify, merge, publish, distribute, sublicense, and/or
#               sell copies of the Software, and to permit persons to whom the
#               Software is furnished to do so, subject to the following
#               conditions:
#
#               The above copyright notice and this permission notice shall be
#               included in all copies or substantial portions of the Software.
#
#               THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#               EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
#               OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#               NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
#               HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
#               WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#               FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#               OTHER DEALINGS IN THE SOFTWARE.
###############################################################################

source ./lib/helper_functions

echo
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░▀█▀░█▀█░▀█▀░▀█▀░░░░█▀▀░█░█░░░" green
figlet_echo "░░░░█░░█░█░░█░░░█░░░░░▀▀█░█▀█░░░" green
figlet_echo "░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀░░▀▀▀░▀░▀░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" green
echo
color_echo "---------------------------------------" red
color_echo "|                                     |" red
color_echo "|  MAKE SURE YOU CLONE THIS GIT REPO  |" red
color_echo "|   INSIDE THE ~/.config DIRECTORY    |" red
color_echo "|                                     |" red
color_echo "---------------------------------------" red
sleep 2


##---------------------------------------------------------------------------//
##
## => BACKUP OLD DOTFILES
##
##---------------------------------------------------------------------------//
echo
color_echo "Backup the old dotfiles (up to 2 times) to ~/.dotfiles.old ..." cyan
if [ -d ~/.dotfiles.old ]; then
	if [ -d /tmp/old.dotfiles ]; then
		rm -rf /tmp/old.dotfiles
	fi
	mv -f ~/.dotfiles.old /tmp/old.dotfiles
fi
mkdir -p ~/.dotfiles.old

if [[ -f ~/.profile || -L ~/.profile ]]; then
	mv -f ~/.profile ~/.dotfiles.old
fi
if [[ -f ~/.bashrc || -L ~/.bashrc ]]; then
	mv -f ~/.bashrc ~/.dotfiles.old
fi
if [[ -f ~/.zshrc || -L ~/.zshrc ]]; then
	mv -f ~/.zshrc ~/.dotfiles.old
fi
if [[ -f ~/.gitconfig || -L ~/.gitconfig ]]; then
	mv -f ~/.gitconfig ~/.dotfiles.old
fi
if [[ -f ~/.gitignore_global || -L ~/.gitignore_global ]]; then
	mv -f ~/.gitignore_global ~/.dotfiles.old
fi
if [[ -f ~/.tmux.conf || -L ~/.tmux.conf ]]; then
	mv -f ~/.tmux.conf ~/.dotfiles.old
fi
if [[ -f ~/.vimrc || -L ~/.vimrc ]]; then
	mv -f ~/.vimrc ~/.dotfiles.old
fi
if [[ -d ~/.vim || -L ~/.vim ]]; then
	mv -f ~/.vim ~/.dotfiles.old
fi
if [[ -d ~/.bin || -L ~/.bin ]]; then
	mv -f ~/.bin ~/.dotfiles.old
fi
if [[ -d ~/.oh-my-zsh || -L ~/.oh-my-zsh ]]; then
	mv -f ~/.oh-my-zsh ~/.dotfiles.old
fi

echo
color_echo "You can find them at ~/.dotfiles.old" cyan


##---------------------------------------------------------------------------//
##
## => CREATING THE SYMLINKS
##
##---------------------------------------------------------------------------//
echo
color_echo "Creating the Symlinks ..." cyan
ln -s "$HOME"/.config/dotfiles/bin                  "$HOME"/.bin
ln -s "$HOME"/.config/dotfiles/bash/bashrc          "$HOME"/.bashrc
ln -s "$HOME"/.config/dotfiles/bash/bash_profile    "$HOME"/.profile

ln -s "$HOME"/.config/dotfiles/gitconfig/gitconfig  "$HOME"/.gitconfig
ln -s "$HOME"/.config/dotfiles/gitconfig/gitignore  "$HOME"/.gitignore_global

ln -s "$HOME"/.config/dotfiles/tmux/tmux.conf       "$HOME"/.tmux.conf

ln -s "$HOME"/.config/dotfiles/zsh/zshrc            "$HOME"/.zshrc


#############################################################################//
#
# => ADDING REPOSITORIES AND ENABLE SNAPS
#
#############################################################################//

color_echo "Enabling Multiverse Repos " cyan
  sudo add-apt-repository multiverse

color_echo "Enabling Snapd " cyan
  sudo apt install -y snapd