#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/helpers'

def install_virtualbox
  if os_is_linux?
    case LinuxOS.distro
    when 'ubuntu'

      if LinuxOS.version == '18.04'
        system('sudo apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian bionic contrib"')
      end

      system('wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add - ')
      system('wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add - ')
      system('sudo apt update -y')
    end
  end

  install_packages(
    ubuntu: ['virtualbox-6.0']
  )
end


def install_dev_software
  subtitle 'Installing GNUPG ...'
  install_packages(
    ubuntu: ['gpg']
  )

  subtitle 'Installing Postman ...'
  install_packages(
    snap: ['postman']
  )

  subtitle 'Installing tmux, a Terminal Multiplexer ...'
  install_packages(
    ubuntu: ['tmux']
  )

  subtitle 'Installing htop, a Better top ...'
  install_packages(
    ubuntu: ['htop']
  )

  subtitle 'Installing Git-cola, Meld, Gitg and Giggle Diff Viewer ...'
  install_packages(
    ubuntu: %w[
      git-cola
      meld
      giggle
      gitg
    ]
  )

  subtitle 'Installing Ag, faster grep replacement...'
  install_packages(
    ubuntu: %w[
      silversearcher-ag
    ]
  )

  subtitle 'Installing RipGrep, faster grep replacement...'
  install_packages(
    snap: %w[
      ripgrep
      --classic
    ]
  )

  subtitle 'Installing Jupyter QT console'
  install_packages(
    ubuntu: ['jupyter-qtconsole']
  )

  subtitle 'Installing Universal CTAGS, a modern alternative to Exuberant ctags'
  install_packages(
    snap: ['universal-ctags']
  )
  system('sudo snap alias universal-ctags ctags')

  subtitle 'Installing Virtualbox 6 ...'
  install_virtualbox

  subtitle 'Installing Vagrant ...'
  install_packages(
    ubuntu: ['vagrant']
  )

  subtitle 'Installing xcape ...'
  install_packages(
    ubuntu: ['xcape']
  )

  # subtitle 'Install vccw, for Wordpress development...'
  # system('vagrant plugin install vagrant-hostupdater')
  # system('vagrant box add vccw-team/xenial64')

end

def main
  install_dev_software
  # subtitle 'Installing Linters'
  # install_linters
end

main
