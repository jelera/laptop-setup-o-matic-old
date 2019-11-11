#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/helpers'

def initial_setup_ubuntu
  package = 'snapd'

  subtitle 'Enabling Multiverse Repositories ...'
  system('sudo add-apt-repository multiverse')

  subtitle 'Enabling Snap Packages ...'
  system("sudo apt install -y #{package}")
end

def main
  initial_setup_ubuntu
end

main
