#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/helpers'

def install_git
  install_packages(
    ubuntu: %w[
      git
    ]
  )
end

def install_git_extras
  install_packages(
    ubuntu: %w[
      git-extras
    ]
  )
end

def install_git_flow
  install_packages(
    ubuntu: %w[
      git-flow
    ]
  )
end

def main
  subtitle 'Installing Git SCM, A Version Source Control ...'
  install_git

  subtitle 'Installing Git-extras, more porcelain for Git ...'
  install_git_extras

  subtitle 'Installing Git-Flow (AVH Edition), a great workflow for Git ...'
  install_git_flow
end

main
