#!/bin/bash

source ./lib/helper_functions



function update_shell() {
    local shell_path;
    shell_path="$(command -v zsh)"

    color_echo "Changing your shell to zsh ..." cyan
    if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
        color_echo "Adding '$shell_path' to /etc/shells" cyan
        sudo sh -c "echo $shell_path >> /etc/shells"
    fi
    sudo chsh -s "$shell_path" "$USER"
}


##---------------------------------------------------------------------------//
##
## => INSTALL ZSH AND SET IT AS THE DEFAULT SHELL
##
##---------------------------------------------------------------------------//
echo

color_echo "Installing zsh ..." cyan
  sudo apt install -y zsh

case "$SHELL" in
  */zsh)
    if [ "$(command -v zsh)" != '/usr/bin/zsh' ] ; then
      update_shell
    fi
    ;;
  *)
    update_shell
    ;;
esac

##---------------------------------------------------------------------------//
##
## => INSTALL OH-MY-ZSH
##
##---------------------------------------------------------------------------//

color_echo "Installing oh-my-zsh ..." cyan
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh