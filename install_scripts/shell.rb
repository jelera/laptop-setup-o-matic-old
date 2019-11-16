#!/usr/bin/ruby
# frozen_string_literal: true

require_relative './lib/helpers'

def is_zsh_in_shells_file?
  shells_file = '/etc/shells'
  shell_path = `which zsh`.chomp

  File.readlines(shells_file).any? do |line|
    line.include? shell_path
  end
end

def update_zsh_as_default
  shell_path = `which zsh`.chomp
  current_user = ENV['USER']

  subtitle 'Changing the default shell to ZSH ...'

  if is_zsh_in_shells_file?
    subtitle "Adding #{shell_path} to /etc/shells"
    system("sudo sh -c echo #{shell_path} >> /etc/shells")
  end

  system("sudo chsh -s #{shell_path} #{current_user}")
end

def set_zsh_as_default_shell
  current_shell = ENV['SHELL']

  case current_shell
  when /zsh/
    update_zsh_as_default if `which zsh`.chomp != '/usr/bin/zsh'
  else
    update_zsh_as_default
  end
end

def install_zsh
  install_packages(
    ubuntu: %w[
      zsh
    ],
    mac: %w[
      zsh
    ]
  )
end

def main
  subtitle 'Installing ZSH ...'
  install_zsh

  subtitle "Updating ZSH as default shell (if it isn't already)..."
  set_zsh_as_default_shell
end

main
