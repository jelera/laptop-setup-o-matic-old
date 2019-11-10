#!/bin/bash

source ./lib/helper_functions

#===============================================//
# => Common shared libraries for compilation
#===============================================//
color_echo "Installing Essential tools for building and compiling ... " cyan
  sudo apt install -y build-essential automake cmake
  sudo apt install -y gcc make pkg-config libx11-dev libxtst-dev libxi-dev
  sudo apt install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
  sudo apt install -y automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev  libxslt-dev libffi-dev libtool unixodbc-dev unzip curl 

color_echo "Installing Common Libraries for Python and Ruby ... " cyan
  sudo apt install -y libxslt1-dev libcurl4-openssl-dev libksba8 libksba-dev libqtwebkit-dev libreadline-dev libssl-dev zlib1g-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libffi-dev postgresql-server-dev-all libbz2-dev txt2tags

color_echo "Installing Ruby 2.x and its Development Libraries ... " cyan
  sudo apt install -y ruby2.5 ruby2.5-dev

color_echo "Installing Python 3.x Development Libraries ... " cyan
  sudo apt install -y python3-all python3-all-dev python3-pip
