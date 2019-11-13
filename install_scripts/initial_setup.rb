#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/helpers'

def install_flatpak
  subtitle 'Installing Flatpak support ...'

  flatpak_install_command = ''

  if LinuxOS.distro == 'ubuntu'
    if LinuxOS.version == '18.04'
      system('sudo add-apt-repository -y ppa:alexlarsson/flatpak')
      system('sudo apt update -y')
    end

    system('sudo apt install -y flatpak')
    system('flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo')
  end
end

def install_snappy
  if LinuxOS.distro == "ubuntu"
    subtitle 'Enabling Snap Packages ...'
    system('sudo apt install -y snapd')
  end
end

def initial_setup_ubuntu
  subtitle 'Enabling Multiverse Repositories ...'
  system('sudo add-apt-repository multiverse')
end

def main
  if os_is_linux?
    if LinuxOS.distro == "ubuntu"
      initial_setup_ubuntu
    end
    install_snappy
    install_flatpak
  end
end

main
