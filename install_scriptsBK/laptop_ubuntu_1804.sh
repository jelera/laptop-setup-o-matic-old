#!/bin/bash
###############################################################################
#         Name: laptop_ubuntu_1804.sh
#        Usage: sudo ./laptop_ubuntu_1804.u
#
#  Description: This is a helper script that automates the installation of
#               software for Development, SysAdmin, etc.
#
# Last Updated: Tue 22 Oct 2019 05:03:01 PM CDT
#
#    Tested on: Ubuntu 18.04 LTS
#
#   Maintainer: Jose Elera (https://github.com/jelera)
#     Based on: https://github.com/thoughtbot/laptop
#      License: MIT
#               Copyright (c) 2019 Jose Elera
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

#############################################################################//
#
# => HELPER FUNCTIONS
#
#############################################################################//

function color_echo(){
# Usage  : color_echo "string" color
# Credit : http://stackoverflow.com/a/23006365/428786
	local exp=$1;
	local color=$2;
	if ! [[ $color =~ ^[0-9]$ ]] ; then
		case $(echo "$color" | tr '[:upper:]' '[:lower:]') in
			black) color=0 ;;
			red) color=1 ;;
			green) color=2 ;;
			yellow) color=3 ;;
			blue) color=4 ;;
			magenta) color=5 ;;
			cyan) color=6 ;;
			white|*) color=7 ;; # white or invalid color
		esac
	fi

	tput setaf $color;
	printf "\n%s\n" "$exp"
	tput sgr0;
}

function figlet_echo(){
	local exp=$1;
	local color=$2;
	if ! [[ $color =~ ^[0-9]$ ]] ; then
		case $(echo "$color" | tr '[:upper:]' '[:lower:]') in
			black) color=0 ;;
			red) color=1 ;;
			green) color=2 ;;
			yellow) color=3 ;;
			blue) color=4 ;;
			magenta) color=5 ;;
			cyan) color=6 ;;
			white|*) color=7 ;; # white or invalid color
		esac
	fi

	tput setaf $color;
	printf "\n%s" "$exp"
	tput sgr0;
}



#############################################################################//
#
# => SETUP
#
#############################################################################//

#-----------------------------//
# => Exit install script if
#    any command fails
#-----------------------------//
set -e

#-----------------------------//
# => Require root privileges
#-----------------------------//
if [[ $EUID -ne 0 ]]; then
	echo "ERROR: This script must be run with sudo" 1>&2
	exit 1
fi

#-----------------------------//
# => Distro Testing
#-----------------------------//
if ! grep -qiE 'bionic' /etc/os-release; then
	echo "ERROR: This Linux Distro is not currently supported" 1>&2
	echo "       Try forking it and implement it" 1>&2
	exit 1
fi




figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░░░░█▀▀░█▀█░█▀▀░▀█▀░█░█░█▀█░█▀▄░█▀▀░░░" green
figlet_echo "░░░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░░░░▀▀█░█░█░█▀▀░░█░░█▄█░█▀█░█▀▄░█▀▀░░░" green
figlet_echo "░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀░░░░▀░░▀░▀░▀░▀░▀░▀░▀▀▀░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░░░░░░█░█░█▀▄░█░█░█▀█░▀█▀░█░█░░░█▀▄░█▀▀░█▀▀░█░█░▀█▀░█▀█░█▀█░░░░░░" green
figlet_echo "░░░░░░░░█░█░█▀▄░█░█░█░█░░█░░█░█░░░█░█░█▀▀░▀▀█░█▀▄░░█░░█░█░█▀▀░░░░░░" green
figlet_echo "░░░░░░░░▀▀▀░▀▀░░▀▀▀░▀░▀░░▀░░▀▀▀░░░▀▀░░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀░░░░░░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░\n\n" green


#############################################################################//
#
# => ADDING REPOSITORIES AND ENABLE SNAPS
#
#############################################################################//

color_echo "Enabling Multiverse Repos " cyan
  add-apt-repository multiverse

color_echo "Enabling Snapd " cyan
  apt install -y snapd



#############################################################################//
#
# => SOFTWARE INSTALLATION (DESKTOP)
#
#############################################################################//

#===============================================//
# => Look and Feel
#===============================================//
color_echo "Installing Steam ... " cyan
  # apt install -y steam
  apt install -y wget gdebi-core libgl1-mesa-dri:i386 libgl1-mesa-glx:i386
  wget http://media.steampowered.com/client/installer/steam.deb
  dpkg -i steam.deb
  rm steam.deb

color_echo "Installing Fonts ... " cyan
  apt install -y fonts-firacode
  apt install -y fonts-roboto
  apt install -y fonts-inconsolata
  apt install -y fonts-font-awesome

color_echo "Install MS Core Fonts" cyan
  echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
  apt install -y ttf-mscorefonts-installer

color_echo "Installing Themes and Icons ... " cyan
  apt install -y shimmer-themes
  apt install -y elementary-icon-theme
  apt install -y humanity-icon-theme
  apt install -y ubuntu-mono
  apt install -y libreoffice-style-galaxy

#===============================================//
# => Desktop Software
#===============================================//
color_echo "Installing restricted extras ... " cyan
  apt install -y ubuntu-restricted-extras

color_echo "Installing Skype ... " cyan
  snap install skype --classic

color_echo "Installing Dropbox ... " cyan
  apt install -y dropbox

color_echo "Installing Filezilla FTP Client ... " cyan
  apt install -y filezilla

color_echo "Installing Font Manager ... " cyan
  apt install -y font-manager

color_echo "Installing Hexchat IRC Client ... " cyan
  apt install -y hexchat
  apt install -y hexchat-plugins

#===============================================//
# => Web Browsers
#===============================================//
color_echo "Installing Google Chrome ... " cyan
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  dpkg -i google-chrome-stable_current_amd64.deb

#===============================================//
# => Multimedia
#===============================================//
color_echo "Installing VLC Media Player ... " cyan
  snap install vlc

color_echo "Installing Google Play Music Desktop Player ... " cyan
  snap install google-play-music-desktop-player

#===============================================//
# => Graphic Tools
#===============================================//
color_echo "Installing Inkscape Vector Image Editor ... " cyan
  snap install inkscape

color_echo "Installing Gimp Image Raster Editor ... " cyan
  snap install gimp

color_echo "Installing Gimp Plugins and extras ... " cyan
  apt install -y gimp-plugin-registry gimp-data-extras gnome-xcf-thumbnailer gimp-gmic gimp-texturize

color_echo "Installing Gpick Color Picker ... " cyan
  apt install -y gpick

color_echo "Installing pngquant, PNG quantization tool for reducing image filesize  ... " cyan
  apt install -y pngquant

#===============================================//
# => Games
#===============================================//

color_echo "Installing OpenTTD, a Open Source Transport Tycoon clone ... " cyan
  apt install -y openttd

color_echo "Installing DosBox,an Emulator of IBM PC compatible computer running DOS... " cyan
  apt install -y dosbox


#===============================================//
# => Utilities
#===============================================//
color_echo "Installing Rar, Unzip and other Archiving utilities ... " cyan
  apt install -y unzip unace p7zip-rar sharutils rar arj lunzip lzip

color_echo "Installing Curl ... " cyan
  apt install -y curl

color_echo "Installing Par, a text formatter filter... " cyan
  apt install -y par

# color_echo "Installing Guake, the Dropdown Terminal ... " cyan
#   apt-get install -y guake

color_echo "Installing Hardinfo, a system information tool ... " cyan
  apt install -y hardinfo

color_echo "Installing LuckyBackup, a Rsync frontend ... " cyan
  apt install -y luckybackup

#===============================================//
# => PPA's, DEB's and Source Compilation
#===============================================//
#-----------------------------//

#-----------------------------//
# => Pandoc
#-----------------------------//
color_echo "Installing Pandoc, a swiss armyknife for Documents... " cyan
  apt install -y pandoc
  apt install -y texlive

#-----------------------------//
# => Albert Launcher
#-----------------------------//
color_echo "Installing Albert Launcher ... " cyan
  sh -c "echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/home:manuelschneid3r.list"
  wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_18.04/Release.key -O Release.key
  apt-key add - < Release.key
  apt-get update
  apt install -y albert

#-----------------------------//
# => Zeal Docs
#-----------------------------//
color_echo "Installing Zeal Documentation Browser ... " cyan
  add-apt-repository -y ppa:zeal-developers/ppa
  apt-get update
  apt-get install -y zeal

#-----------------------------//
# => Wine
#-----------------------------//
color_echo "Installing Wine, Wine is not an Emulator ... " cyan
  wget -nc https://dl.winehq.org/wine-builds/winehq.key
  apt-key add winehq.key
  apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
  apt update
  apt install --install-recommends -y winehq-stable

#-----------------------------//
# => PlayOnLinux
#-----------------------------//
color_echo "Installing PlayOnLinux, A Frontend for Wine ... " cyan
  wget -q "http://deb.playonlinux.com/public.gpg" -O- | apt-key add -
  wget http://deb.playonlinux.com/playonlinux_bionic.list -O /etc/apt/sources.list.d/playonlinux.list
  apt update
  apt install -y playonlinux

#-----------------------------//
# => Handbrake
#-----------------------------//
color_echo "Installing Handbrake, an open source video converter ..." cyan
  add-apt-repository -y ppa:stebbins/handbrake-releases
  apt update
  apt install -y handbrake


#############################################################################//
#
# => SOFTWARE INSTALLATION (DEVELOPMENT)
#
#############################################################################//

#===============================================//
# => Development Tools
#===============================================//

color_echo "Installing Vim text editor... " cyan
  apt install -y vim-gnome

color_echo "Installing GNUPG... " cyan
  apt install -y gpg

color_echo "Installing Postman... " cyan
  snap install postman


color_echo "Installing Tmux terminal multiplexer ... " cyan
  apt install -y tmux

color_echo "Installing Htop ... " cyan
  apt install -y htop

color_echo "Installing Meld Diff Viewer ... " cyan
  apt install -y meld

color_echo "Installing Giggle Git Viewer ... " cyan
  apt install -y giggle
  apt install -y gitg

color_echo "Installing Git-Flow, a great workflow for git ... " cyan
  apt install -y git-flow

color_echo "Installing Git-extras, more porcelain for git ... " cyan
  apt install -y git-extras

color_echo "Installing Ag The Silver Searcher as a Grep replacement ... " cyan
  apt install -y silversearcher-ag

#===============================================//
# => Common shared libraries for compilation
#===============================================//
color_echo "Installing Essential tools for building and compiling ... " cyan
  apt install -y build-essential automake cmake
  apt install -y gcc make pkg-config libx11-dev libxtst-dev libxi-dev
  apt install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
  apt install -y automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev  libxslt-dev libffi-dev libtool unixodbc-dev unzip curl 


color_echo "Installing Ruby 2.x and its Development Libraries ... " cyan
  apt install -y ruby2.5 ruby2.0-dev

color_echo "Installing Python 3.x Development Libraries ... " cyan
  apt install -y python3-all python3-all-dev python3-pip

color_echo "Installing jupyter with QT Consoles ..." cyan
  apt install -y jupyter-qtconsole

color_echo "Installing Common Libraries for Python and Ruby ... " cyan
  apt install -y libxslt1-dev libcurl4-openssl-dev libksba8 libksba-dev libqtwebkit-dev libreadline-dev libssl-dev zlib1g-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libffi-dev postgresql-server-dev-all libbz2-dev txt2tags

#===============================================//
# => STACKS
#===============================================//
# Yarn
 curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
     echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list


#===============================================//
# => PPA's, DEB's and Source Compilation
#===============================================//

#-----------------------------//
# => Node.js
#-----------------------------//
color_echo "Installing Node.js ... " cyan
  curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
  apt install -y nodejs

#-----------------------------//
# => Universal Ctags
#-----------------------------//
color_echo "Installing Universal Ctags, a more updated alternative to Exuberant Ctags ... " cyan
  snap install universal-ctags
  snap alias universal-ctags ctags

#-----------------------------//
# => Git SCM
#-----------------------------//
color_echo "Installing Git Source Code Management ... " cyan
  add-apt-repository -y ppa:git-core/ppa
  apt update
  apt install -y git

#-----------------------------//
# => VirtualBox
#-----------------------------//
color_echo "Installing VirtualBox 6 ... " cyan
if grep -qiE 'bionic' /etc/os-release; then
	apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian bionic contrib"
	wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
	wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
	apt update
	apt install -y virtualbox-6.0
fi

#-----------------------------//
# => Vagrant
#-----------------------------//
color_echo "Installing Vagrant 2.2.5  ... " cyan
  # cd /tmp
  # wget https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_x86_64.deb
  # dpkg -i vagrant_2.2.5_x86_64.deb
  # cd "$HOME"
  apt install -y vagrant

#-----------------------------//
# => Git-cola
#-----------------------------//
color_echo "Installing Git-Cola Git Viewer ... " cyan
  apt install -y git-cola

#-----------------------------//
# => Visual Studio Code
#-----------------------------//
color_echo "Installing VSCode text editor ... " cyan
  snap install code --classic

#-----------------------------//
# => xcape
#-----------------------------//
color_echo "Installing Xcape, remap pressing one time CTRL to ESC, very good for Vim" cyan
  apt install -y xcape

#===============================================//
# => Wordpress
#===============================================//
  vagrant plugin install vagrant-hostsupdater
  vagrant box add vccw-team/xenial64

#===============================================//
# => Ruby Gems
#===============================================//
color_echo "Upgrading current gems..." cyan
  gem install --system

color_echo "Installing Bundler..." cyan
  gem install bundler

color_echo "Installing Nokogiri..." cyan
  gem install nokogiri

color_echo "Installing Sinatra..." cyan
  gem install sinatra

color_echo "Installing Rails..." cyan
  gem install rails




#===============================================//
# => NPM Packages
#===============================================//
color_echo "Upgrading npm with npm" cyan
  npm install -g npm

color_echo "Installing Commonmark, an strict superset of Markdown" cyan
  npm install -g commonmark
  ln -s /usr/bin/commonmark /usr/bin/markdown

color_echo "Installing Markdown to PDF" cyan
  npm install -g markdown-pdf

# color_echo "Installing Tern, Code-analysis engine for JavaScript ... " cyan
#   npm install -g tern
color_echo "Install Sass, a CSS Preprocessor" cyan
  npm install -g sass

color_echo "Installing JSCtags, Ctags tags generator for JavaScript Sources ... " cyan
  npm install -g git+https://github.com/ramitos/jsctags.git

color_echo "Installing Gulp Task Runner ... " cyan
  npm install -g gulp

color_echo "Installing BrowserSync, Live preview for Web Development ... " cyan
  npm install -g browser-sync

color_echo "Installing Foundation CLI ... " cyan
  npm install -g bower
  npm install -g foundation-cli

color_echo "Installing Write-good, Linter for English proves for devs... " cyan
  npm install -g write-good



#===============================================//
# => LINTERS
#===============================================//
color_echo "Installing Prettier" cyan
  npm install -g prettier

color_echo "Installing Pylint, for Python" cyan
  pip3 install pylint

color_echo "Installing Rubocop, for Ruby" cyan
  gem install solargraph
  gem install rubocop

color_echo "Installing Language-check, for Text Proof-reading" cyan
  pip3 install --upgrade language-check

# BASH
color_echo "Installing ShellCheck, for Bash" cyan
  apt install -y shellcheck


#############################################################################//
#
# => CLEANUP
#
#############################################################################//

color_echo "Cleaning up!..." cyan
  apt autoremove
  rm -rf /tmp/* 2> /dev/null
echo
echo
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░█░█░█▀█░█░█░█▀▄░░░█▀▀░█▀█░█▄█░█▀█░█░█░▀█▀░█▀▀░█▀▄░░░" green
figlet_echo "░░░░█░░█░█░█░█░█▀▄░░░█░░░█░█░█░█░█▀▀░█░█░░█░░█▀▀░█▀▄░░░" green
figlet_echo "░░░░▀░░▀▀▀░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░░▀░░▀▀▀░▀░▀░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░╻┏━┓░░░░░░░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░┃┗━┓░░░░░░░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░╹┗━┛░░░░░░░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░█▀▄░█▀▀░█▀█░█▀▄░█░█░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░█▀▄░█▀▀░█▀█░█░█░░█░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░▀░▀░▀▀▀░▀░▀░▀▀░░░▀░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" green
figlet_echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░" green
