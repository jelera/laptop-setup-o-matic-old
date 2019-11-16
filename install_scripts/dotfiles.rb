#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/helpers'
require 'fileutils'

def backup_exisiting_dotfiles
  home_dir = Dir.home || File.expand_path('~') || ENV['HOME']
  # dotfiles_dir = File.join(home_dir, '.config', 'dotfiles')

  old_dotfiles_dir = File.join(home_dir, '.dotfiles.old')
  older_dotfiles_dir = File.join(home_dir, '.dotfiles.old.1')

  files = %w[
    .profile
    .bashrc
    .zshrc
    .gitconfig
    .gitignore_global
    .tmux.conf
    .vimrc
    .vim
    .bin
    .oh-my-zsh
  ]

  if Dir.exist? old_dotfiles_dir
    FileUtils.rm_rf(older_dotfiles_dir) if Dir.exist? older_dotfiles_dir
    FileUtils.mv(old_dotfiles_dir, older_dotfiles_dir, force: true)
  end
  FileUtils.mkdir(old_dotfiles_dir)

  files.each do |filename|
    save_file_to_old_dotfiles_dir filename
  end
end

def save_file_to_old_dotfiles_dir(filename)
  home_dir = Dir.home || File.expand_path('~') || ENV['HOME']
  old_dotfiles_dir = File.join(home_dir, '.dotfiles.old')

  if File.exist? File.join(home_dir, filename)
    FileUtils.mv(
      File.join(home_dir, filename),
      old_dotfiles_dir,
      force: true
    )
  end
end

def create_symlinks
  home_dir = Dir.home || File.expand_path('~') || ENV['HOME']
  dotfiles_dir = File.join(home_dir, '.config', 'dotfiles')

  # -------------------------------------------------------------------------- #
  # => BIN FOLDER
  # -------------------------------------------------------------------------- #

  # ~/.bin folder
  Fileutils.symlink(
    File.join(dotfiles_dir, 'bin'),
    File.join(dotfiles_dir, '.bin')
  )

  # -------------------------------------------------------------------------- #
  # => SHELL (BASH, ZSH)
  # -------------------------------------------------------------------------- #

  # .profile
  Fileutils.symlink(
    File.join(dotfiles_dir, 'bash', 'bash_profile'),
    File.join(dotfiles_dir, '.profile')
  )

  # .bashrc
  Fileutils.symlink(
    File.join(dotfiles_dir, 'bash', 'bashrc'),
    File.join(dotfiles_dir, '.bashrc')
  )

  # .zshrc
  Fileutils.symlink(
    File.join(dotfiles_dir, 'zsh', 'zshrc'),
    File.join(dotfiles_dir, '.zshrc')
  )

  # -------------------------------------------------------------------------- #
  # => GIT
  # -------------------------------------------------------------------------- #

  # .gitconfig
  Fileutils.symlink(
    File.join(dotfiles_dir, 'gitconfig', 'gitconfig'),
    File.join(dotfiles_dir, '.gitconfig')
  )

  # .gitignore global
  Fileutils.symlink(
    File.join(dotfiles_dir, 'gitconfig', 'gitignore'),
    File.join(dotfiles_dir, '.gitignore_global')
  )

  # -------------------------------------------------------------------------- #
  # => TMUX
  # -------------------------------------------------------------------------- #

  # .tmux.conf
  Fileutils.symlink(
    File.join(dotfiles_dir, 'tmux', 'tmux.conf'),
    File.join(dotfiles_dir, '.tmux.conf')
  )
end

def main
  subtitle 'Backing up existing dotfiles to ~/.dotfiles.old'
  backup_exisiting_dotfiles

  subtitle 'Creating the symlinks to the dotfiles...'
  create_symlinks
end

main
