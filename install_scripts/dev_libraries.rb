#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/helpers'

def install_essential_dev_tools
  install_packages(
    ubuntu: %w[
      build-essential
      automake
      cmake
      autoconf
      bison
      gcc
      make
      pkg-config
      unzip
      curl
      sqlite3
      postgresql-server-dev-all
      unixodbc-dev
      txt2tags
      zlib1g-dev
    ]
  )
end

def install_dev_libraries
  install_packages(
    ubuntu: %w[
      libtool
      libx11-dev
      libxtst-dev
      libxi-dev
      libxslt1-dev
      libxslt-dev
      libxml2-dev
      libssl-dev
      libyaml-dev
      libreadline6-dev
      libreadline-dev
      libbz2-dev
      libncurses5-dev
      libncurses-dev
      libffi-dev
      libgdbm5
      libgdbm-dev
      libcurl4-openssl-dev
      libsqlite3-dev
      libksba8
      libksba-dev
      libqtwebkit-dev
    ]
  )
end

def install_ruby_dev

  install_packages(
    ubuntu: %w[
      ruby
      ruby-dev
      ruby2.5
      ruby2.5-dev
    ]
  )
end

def install_python_dev
  install_packages(
    ubuntu: %w[
      python3-all
      python3-all-dev
      python3-pip
    ]
  )
end

def main
  subtitle 'Installing Essential Tools for Building and Compiling ...'
  install_essential_dev_tools

  subtitle 'Installing Common Development Libraries ...'
  install_dev_libraries

  subtitle 'Installing Ruby 2.5 and its Development Libraries ...'
  install_ruby_dev

  subtitle 'Installing Python 3 and its Development Libraries ...'
  install_python_dev
end

main
