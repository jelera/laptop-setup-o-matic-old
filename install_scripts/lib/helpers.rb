#!/usr/bin/ruby
# frozen_string_literal: true

require_relative './linux_helpers'

require 'etc'
require 'yaml'
require 'colorize'
require 'fileutils'
require 'pry'

def settings
  YAML.safe_load(File.read('../config.yml'))
end

def subtitle(text)
  console_width = ENV['COLUMNS'].to_i
  puts ""
  puts ""
  puts text.colorize(:light_cyan)
  console_width.times { print '-'.colorize(:light_cyan) }
  puts ""
end

def this_system
  `uname`.chomp
end

def user_sudo?
  Etc.getpwuid.uid.zero?
end

def os_is_mac?
  this_system == 'Darwin'
end

def os_is_linux?
  this_system == 'Linux'
end

def os_supported?
  exit 1 unless os_is_linux? || os_is_mac?
  settings['os-supported'].include? LinuxOS.distro
end

def install_packages(ubuntu: [], snap: [], arch: [], aur: [], flatpak: [], mac: [])
  if os_is_linux?
    LinuxOS.install_packages(ubuntu, snap, flatpak, arch, aur)
  # elsif os_is_mac?
  #   ""
  end
end

def install_gem(local:[], global:[])
  gem_command = 'gem'
  packages = ''

  if !local.empty?
    packages = local.join(' ')
  elsif !global.empty?
    gem_command = "sudo #{gem_command}"
    packages = global.join(' ')
  end

  system("#{gem_command} install #{packages}")
end

def install_pip(local:[], global:[])
  pip_command = 'pip'
  pip_command = 'pip3' if LinuxOS.distro == 'ubuntu'

  if !local.empty?
    packages = local.join(' ')
  elsif !global.empty?
    pip_command = "sudo #{pip_command}"
    packages = global.join(' ')
  end

  system("#{pip_command} install #{packages}")
end

def install_npm(local:[], global:[])
  npm_command = 'npm'
  global_flag = ''
  packages = ''

  if !local.empty?
    packages = local.join(' ')
  elsif !global.empty?
    npm_command = "sudo #{npm_command}"
    global_flag = '--global'
    packages = global.join(' ')
  end

  system("#{npm_command} install #{global_flag} #{packages}")
end

binding.pry

