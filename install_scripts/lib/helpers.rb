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

def install_packages(ubuntu: [], arch: [], mac: [])
  if os_is_linux?
    LinuxOS.install_packages ubuntu
  # elsif os_is_mac?
  #   ""
  end
end



binding.pry

