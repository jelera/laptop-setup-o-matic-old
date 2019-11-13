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

def install_gem(gem_name)
  system("gem install #{gem_name}")
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
def install_linters
  subtitle 'Installing Prettier ...'
  install_npm('prettier')

  subtitle 'Installing Pylint ...'
  system('pip3 install pylint')

  subtitle 'Installing Rubocop ...'
  install_gem('solargraph')
  install_gem('rubocop')

  subtitle 'Installing ShellCheck ...'
  install_packages(
    snap: ['shellcheck']
  )
end

def install_npm_packages
  subtitle 'Upgrading npm with npm'
  install_npm('npm')

  subtitle 'Installing Yarn, a Fast and Reliable Dependency Manager ...'
  install_npm('yarn')

  subtitle 'Installing Tern, Code-analysis engine for JavaScript ...'
  install_npm('tern')

  subtitle 'Install Sass, a CSS Preprocessor ...'
  install_npm('sass')

  subtitle 'Install JSCtags, a CTAGS generator for JS Sources ...'
  install_npm('git+https://github.com/ramitos/jsctags.git')

  subtitle 'Install BrowserSync, a CTAGS generator for JS Sources ...'
  install_npm('browser-sync')

  subtitle 'Install Commonmark, a superset of Markdown ...'
  install_npm('commonmark')

  subtitle 'Install Commonmark, a superset of Markdown ...'
  install_npm('commonmark')

  subtitle 'Install write-good ...'
  install_npm('write-good')

  subtitle 'Install create-react-app ...'
  system('yarn global add create-react-app')

  subtitle 'Install Prettier ...'
  system('yarn global add prettier')
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

  subtitle 'Installing Linters ... '
  install_linters
end

main
