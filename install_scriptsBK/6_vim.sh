#!/bin/bash

source ./lib/helper_functions

#-----------------------------------------------------------------------------//
# => Purging Vim (Ubuntu Package)
#-----------------------------------------------------------------------------//
# This step must be done because there is a bug in the ubuntu 18.04 `vim`
# package.

# One fix to this bug is to compile from source

sudo apt purge -y \
	vim \
	vim-runtime \
	gvim \
	vim-tiny \
	vim-gtk \
	vim-common \
	vim-gnome \
	vim-gui-common

#-----------------------------------------------------------------------------//
# => Cloning from the official repo and compile with huge features
#-----------------------------------------------------------------------------//

cd /tmp || exit
git clone git@github.com:vim/vim.git --depth=1
cd vim || exit
./configure --with-features=huge \
	--enable-rubyinterp \
	--enable-python3interp \
	--enable-perlinterp \
	--enable-luainterp \
	--enable-gui=auto

make
sudo make install
cd ..
rm -rf vim
cd ~/.config


##---------------------------------------------------------------------------//
##
## => SETTING UP VIM
##
##---------------------------------------------------------------------------//
echo
color_echo "---------------------------------------" yellow
color_echo "|                                      |" yellow
color_echo "|  Setting up Vim Configuration Files  |" yellow
color_echo "|                                      |" yellow
color_echo "----------------------------------------" yellow
echo

color_echo "Checking if dotvim repo is installed..." cyan
echo

color_echo "If it is... it will be moved to .dotfiles.old dir" red
sleep 2
if [[ -d ~/.config/dotfiles/vim || -L ~/.config/dotfiles/vim ]]; then
	mv -f ~/.config/dotfiles/vim ~/.dotfiles.old
fi

color_echo "Cloning my dotvim repo ..." cyan
# Cloning my dotvim repo and create the symlinks
git clone git@github.com:jelera/vimconfig.git ~/.config/dotfiles/vim
ln -s "$HOME"/.config/dotfiles/vim     "$HOME"/.vim

# Making the directories for backup, swap and undo
echo
color_echo "Making directories within .vim for backup, swap and undo ..." cyan
mkdir -p ~/.vim/.cache
mkdir -p ~/.vim/.cache/backup
mkdir -p ~/.vim/.cache/swap
mkdir -p ~/.vim/.cache/undo
mkdir -p ~/.vim/.cache/unite
mkdir -p ~/.vim/.cache/junk

echo
color_echo "Installing Vim-plug, a very good Vim Plugin Manager ..." cyan
# I'm aware of Vim 8 built-in plugin manager, but I like this one better,
# Don't be hatin'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -E -c PlugInstall -c q -c q
color_echo "Done Installing Vim Plugins" cyan


#-----------------------------------------------------------------------------//
# => Install Coc.nvim sources
#-----------------------------------------------------------------------------//

# Words from files in `&dictionary`
vim -E -c 'CocInstall coc-dictionary'-c q

# Words from `tagfiles()`
vim -E -c 'CocInstall coc-tag'-c q

# Words from Google's 10000 English repo
vim -E -c 'CocInstall coc-word'-c q



