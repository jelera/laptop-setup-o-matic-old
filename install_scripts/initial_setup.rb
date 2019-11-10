#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/helpers'

def initial_setup
  package = 'ruby'

  system('sudo add-apt-repository multiverse')
  system("sudo apt install -y #{package}")
end

def main
  initial_setup
end

main
