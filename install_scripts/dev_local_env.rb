#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/helpers'

def add_or_update_asdf_plugin(plugin_name, url)
  plugin_list = `asdf plugin-list`.split("\n")

  if !plugin_list.include? plugin_name
    system("asdf plugin-add #{plugin_name} #{url}")
  else
    system("asdf plugin-update #{plugin_name}")
  end
end

def install_asdf_language(language)
  latest_version = `asdf list-all #{language} | grep -v "[a-z]" | tail -1`.strip
  installed_version = `asdf list #{language}`.strip

  return if installed_version == latest_version

  system("asdf install #{language} #{latest_version}")
  system("asdf global #{language} #{latest_version}")
end

def install_asdf
  asdf_dir = File.join(Dir.home, '.asdf')
  asdf_url = 'https://github.com/asdf-vm/asdf.git'
  zshrc_file = File.join(Dir.home, '.zshrc')

  unless Dir.exist? asdf_dir
    system("git clone #{asdf_url} #{asdf_dir}")
    FileUtils.cd(asdf_dir)
    `git checkout "$(git describe --abbrev=0 --tags)"`
    FileUtils.cd(ENV['HOME'])
  end

  `echo -e "\n. #{File.join(asdf_dir, 'asdf.sh')} >> #{zshrc_file}"`
  `echo -e "\n. #{File.join(asdf_dir, 'completions', 'asdf.bash')} >> #{zshrc_file}"`

  system("source #{zshrc_file}")

  system('asdf update')

  system("source #{File.join(asdf_dir, 'asdf.sh')}")
end

def install_ruby_asdf
  asdf_url = 'https://github.com/asdf-vm/asdf-ruby.git'

  add_or_update_asdf_plugin('ruby', asdf_url)
  install_asdf_language('ruby')

  system('gem update --system')
  system('gem install bundler')

  if os_is_linux?
    number_of_cores = `cat /proc/cpuinfo | grep processor | wc -l`.strip.to_i
  elsif os_is_mac?
    number_of_cores = `sysctl -n hw.ncpu`.strip.to_i
  end

  system("bundle config --global jobs #{number_of_cores - 1}")
end


def install_rubygems_asdf
  subtitle 'Installing Nokogiri'
  install_gem('nokogiri')

  subtitle 'Installing Sinatra'
  install_gem('sinatra')

  subtitle 'Installing Rails'
  install_gem('rails')

  subtitle 'Installing Rubocop'
  install_gem('rubocop')

  subtitle 'Installing Pry'
  install_gem('pry')

  subtitle 'Installing Solargraph'
  install_gem('solargraph')
end

def install_nodejs_asdf
  asdf_url = 'https://github.com/asdf-vm/asdf-nodejs.git'
  release_keyring = File.join(Dir.home, '.asdf', 'plugins', 'nodejs', 'bin', 'import-release-team-keyring')

  add_or_update_asdf_plugin('nodejs', asdf_url)
  `bash #{release_keyring}`
  install_asdf_language('nodejs')
end

def install_npm(package_name)
  system("npm install -g #{package_name}")
end

def install_npm_packages
  subtitle 'Install create-react-app ...'
  system('yarn global add create-react-app')
end

def main
  subtitle 'Installing asdf ...'
  install_asdf

  subtitle 'Installing a Ruby Local Environment via asdf ...'
  install_ruby_asdf

  subtitle 'Installing Rubygems for Ruby asdf ...'
  install_rubygems_asdf

  subtitle 'Installing a Node.js Local Environment via asdf ...'
  install_nodejs_asdf

  subtitle 'Installing NPM packages for Node.JS  asdf ...'
  install_npm_packages
end

main
