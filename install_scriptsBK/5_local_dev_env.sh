#!/bin/bash

source ./lib/helper_functions

#############################################################################//
#
# => Dedicated helper functions
#
#############################################################################//

alias install_asdf_plugin=add_or_update_asdf_plugin

add_or_update_asdf_plugin() {
  local name="$1"
  local url="$2"

  if ! asdf plugin-list | grep -Fq "$name"; then
    asdf plugin-add "$name" "$url"
  else
    asdf plugin-update "$name"
  fi
}

install_asdf_language() {
  local language="$1"
  local version
  version="$(asdf list-all "$language" | grep -v "[a-z]" | tail -1)"

  if ! asdf list "$language" | grep -Fq "$version"; then
    asdf install "$language" "$version"
    asdf global "$language" "$version"
  fi
}

#############################################################################//
#
# => INSTALL ASDF
#
#############################################################################//

if [ ! -d "$HOME/.asdf" ]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    cd ~/.asdf || exit
    git checkout "$(git describe --abbrev=0 --tags)"
    append_to_zshrc "source $HOME/.asdf/asdf.sh" 1
    cd || return
fi

echo -e "\n. $HOME/.asdf/asdf.sh" >> ~/.zshrc
echo -e "\n. $HOME/.asdf/completions/asdf.bash" >> ~/.zshrc

source ~/.zshrc

asdf update

source "$HOME/.asdf/asdf.sh"


#-----------------------------------------------------------------------------//
# => Install Ruby 
#-----------------------------------------------------------------------------//
color_echo "Installing a Ruby Local Environment ..." cyan

add_or_update_asdf_plugin "ruby" "https://github.com/asdf-vm/asdf-ruby.git"
install_asdf_language "ruby"

# Initial setup for Ruby
gem update --system
gem install bundler

# Set the most efficient way to compile languages
if [ "$(uname)" == "Darwin" ]; then
    number_of_cores=$(sysctl -n hw.ncpu)
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    number_of_cores=$(grep -c ^processor /proc/cpuinfo)
fi
bundle config --global jobs $((number_of_cores - 1))

#-----------------#
# Installing Gems #
#-----------------#
color_echo "Installing a Ruby Gems ..." cyan

color_echo "Installing Nokogiri..." cyan
  gem install nokogiri

color_echo "Installing Sinatra..." cyan
  gem install sinatra

color_echo "Installing Rails..." cyan
  gem install rails


#-----------------------------------------------------------------------------//
# => Install Local Node.js environment 
#-----------------------------------------------------------------------------//
color_echo "Installing a Node.js Local Environment ..." cyan
  add_or_update_asdf_plugin "nodejs" "https://github.com/asdf-vm/asdf-nodejs.git"
  bash "$HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring"
  install_asdf_language "nodejs"

#-------------------------#
# Installing NPM packages #
#-------------------------#
color_echo "Upgrading npm with npm" cyan
  npm install -g npm

color_echo "Install Yarn, Fast and Reliable Dependency Manager" cyan
  npm install --global yarn

color_echo "Installing Tern, Code-analysis engine for JavaScript ... " cyan
  npm install -g tern

color_echo "Install Sass, a CSS Preprocessor" cyan
  npm install -g sass

color_echo "Installing JSCtags, Ctags tags generator for JavaScript Sources ... " cyan
  npm install -g git+https://github.com/ramitos/jsctags.git

cocolor_echo "Installing BrowserSync, Live preview for Web Development ... " cyan
  npm install -g browser-sync

color_echo "Installing Foundation CLI ... " cyan
  npm install -g foundation-cli

color_echo "Installing Foundation CLI ... " cyan
  yarn global add create-react-app
