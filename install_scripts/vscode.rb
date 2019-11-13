#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/helpers'

def install_vscode
  install_packages(
    snap: %w[
      code
      --classic
    ]
  )
end

def main
  install_vscode
end

main
