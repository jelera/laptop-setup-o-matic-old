#!/bin/bash

source ./lib/helper_functions

#-----------------------------//
# => Git SCM
#-----------------------------//
color_echo "Installing Git Source Code Management ... " cyan
  sudo add-apt-repository -y ppa:git-core/ppa
  sudo apt update
  sudo apt install -y git

color_echo "Installing Git-extras, more porcelain for git ... " cyan
  sudo apt install -y git-extras

color_echo "Installing Git-Flow (AVH Edition), a great workflow for git ... " cyan
  sudo apt install -y git-flow