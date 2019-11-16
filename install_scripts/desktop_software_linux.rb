#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/helpers'

def install_fonts
  subtitle 'Installing Fonts ...'
  install_packages(
    ubuntu: %w[
      fonts-firacode
      fonts-roboto
      fonts-inconsolata
    ]
  )

  subtitle 'Installing MS Core Fonts  ...'
  system('echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections')
  install_packages( ubuntu:['ttf-mscorefonts-installer'])
end

def install_zeal
  if LinuxOS.distro == 'ubuntu'
    system('sudo add-apt-repository -y ppa:zeal-developers/ppa')
    system('sudo apt-get update -y')
    install_packages( ubuntu: ['zeal'] )
  end
end

def install_wine
  system( 'wget -nc https://dl.winehq.org/wine-builds/winehq.key' )
  system('sudo apt-key add winehq.key')
  system("sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'")
  system('sudo apt update -y')
  system('sudo apt install --install-recommends -y winehq-stable')
end

def install_playonlinux
  system('wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -')
  system('sudo wget http://deb.playonlinux.com/playonlinux_bionic.list -O /etc/apt/sources.list.d/playonlinux.list')
  system('sudo apt update -y')
  install_packages( ubuntu: ['playonlinux'] )
end

def install_handbrake

  system('sudo add-apt-repository -y ppa:stebbins/handbrake-releases')
  system('sudo apt update')
  system('sudo apt install -y handbrake')
end

def install_linux_themes_icons
  install_packages(
    ubuntu: %w[
      shimmer-themes
      elementary-icon-theme
      humanity-icon-theme
      ubuntu-mono
      libreoffice-style-galaxy
    ]
  )
end

def install_look_and_feel
  install_linux_themes_icons
end

def install_games
  subtitle 'Installing Steam ...'
  install_packages( ubuntu: ['steam'])

  subtitle 'Installing OpenTTD ...'
  install_packages( ubuntu: ['openttd'])

  subtitle 'Installing dosbox ...'
  install_packages( ubuntu: ['dosbox'])
end

def install_destkop_software
  # -------------------------------------------------------------------------- #
  # => 3rd Party Software
  # -------------------------------------------------------------------------- #
  install_games

  subtitle 'Installing Restricted extras ...'
  install_packages(ubuntu: ['ubuntu-restricted-extras'])

  subtitle 'Installing Skype ...'
  install_packages(snap: %w[skype --classic])

  # subtitle 'Installing Dropbox ...'
  # install_packages(ubuntu: ['dropbox'])

  # -------------------------------------------------------------------------- #
  # => Internet
  # -------------------------------------------------------------------------- #
  subtitle 'Installing Filezilla FTP client ...'
  install_packages(ubuntu: ['filezilla'])

  subtitle 'Installing Google Chrome ...'
  FileUtils.cd('/tmp')
  system('wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb')
  system('sudo dpkg -i google-chrome-stable_current_amd64.deb')

  # -------------------------------------------------------------------------- #
  # => Multimedia
  # -------------------------------------------------------------------------- #
  subtitle 'Installing VLC Media Player ...'
  install_packages(snap: ['vlc'])

  subtitle 'Installing Google Play Music Desktop Player ...'
  install_packages(snap: ['google-play-music-desktop-player'])

  # -------------------------------------------------------------------------- #
  # => Graphic Tools
  # -------------------------------------------------------------------------- #
  subtitle 'Installing Inkscape ...'
  install_packages(snap: ['inkscape'])

  subtitle 'Installing Gimp ...'
  install_packages(snap: %w[gimp])

  subtitle 'Installing pngquant and trimage ...'
  install_packages(ubuntu: %w[pngquant trimage])

  # -------------------------------------------------------------------------- #
  # => Utilities
  # -------------------------------------------------------------------------- #
  subtitle 'Installing Rar, Unzip and other archiving utilities... '
  install_packages(
    ubuntu: %w[
      unzip
      unace
      p7zip-rar
      sharutils
      rar
      arj
      lunzip
      lzip
    ]
  )

  subtitle 'Installing Par, a text formatter filter ...'
  install_packages(ubuntu: ['par'])

  subtitle 'Installing Pandoc, The swiss armyknife document exporter ...'
  install_packages(ubuntu: %w[pandoc texlive])

  subtitle 'Installing Zeal Documentation Browser ... '
  install_zeal

  subtitle 'Installing Handbrake, a video converter ... '
  install_handbrake

  subtitle 'Installing Wine, Wine is not an Emulator ... '
  # install_wine
  install_packages(ubuntu: ['wine-stable'])

  subtitle 'Installing PlayOnLinux, a Frontend for Wine ...'
  # install_playonlinux
  install_packages(ubuntu: ['playonlinux'])
end

def main
  install_fonts
  install_look_and_feel
  install_destkop_software
end

main
