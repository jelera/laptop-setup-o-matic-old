#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/helpers'

def purge_vim_from_ubuntu
  packages = %w[
    vim
    vim-runtime
    gvim
    vim-tiny
    vim-gtk
    vim-common
    vim-gnome
    vim-gui-common
  ].join(' ')

  system("sudo apt purge -y #{packages}")
end

def compile_vim_from_source
  vim_github_url = 'git@github.com:vim/vim.git'
  configure_flags = %w[
    --with-features=huge
    --enable-rubyinterp
    --enable-python3interp
    --enable-perlinterp
    --enable-luainterp
    --enable-gui=auto
  ].join(' ')

  system("git clone #{vim_github_url} /tmp/vim --depth=1")

  FileUtils.cd('/tmp/vim')

  system("./configure #{configure_flags}")
  system('make')
  system('sudo make install')
end

def install_vim
  if LinuxOS.distro == 'ubuntu' && LinuxOS.version == '18.04'
    subtitle 'Installing Vim in Ubuntu 18.04 ...'
    puts 'Purge vim from Ubuntu 18.04'.colorize(:light_green).bold
    purge_vim_from_ubuntu
    puts ''
    # puts 'Compile Vim from Source'.colorize(:light_green).bold
    # compile_vim_from_source

    install_packages(
      flatpak: %w[
        org.vim.Vim
      ]
    )
  else
    install_packages(
      ubuntu: %w[
        vim-gnome
      ],
      mac: %w[
        vim
      ]
    )
  end
end

def install_dotvim
  dotvim_github_ssh_url = 'git@github.com:jelera/vimconfig.git'
  dotvim_github_html_url = 'https://github.com/jelera/vimconfig.git'
  dotvim_symlink_dir = File.join(Dir.home, '.vim')
  dotfiles_dir = File.join(Dir.home, '.config', 'dotfiles')
  dotvim_dir = File.join(dotfiles_dir, 'vim')
  gitconfig = File.absolute_path(File.join(Dir.home, '.gitconfig'))

  if File.exist? gitconfig
    system("git clone #{dotvim_github_ssh_url} #{dotvim_dir}")
  else
    system("git clone #{dotvim_github_html_url} #{dotvim_dir}")
  end

  FileUtils.symlink(dotvim_dir, dotvim_symlink_dir)

  FileUtils.mkdir_p(
    File.join(dotvim_symlink_dir, '.cache')
  )
  FileUtils.mkdir_p(
    File.join(dotvim_symlink_dir, '.cache', 'backup')
  )
  FileUtils.mkdir_p(
    File.join(dotvim_symlink_dir, '.cache', 'swap')
  )
  FileUtils.mkdir_p(
    File.join(dotvim_symlink_dir, '.cache', 'undo')
  )
  FileUtils.mkdir_p(
    File.join(dotvim_symlink_dir, '.cache', 'junk')
  )
end

def install_vim_plugins
  system('curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')

  system('vim -E -c PlugInstall -c q -c q')
end

def coc_install(package_name)
  packages = package_name.join(' ')
  system("vim -E -c 'CocInstall -sync #{packages}|q'")
end

def install_coc_nvim_sources
  coc_install(%w[
    coc-dictionary
    coc-tag
    coc-word
    coc-json
    coc-tsserver
    coc-html
    coc-css
    coc-solargraph
    coc-yaml
    coc-python
    coc-highlight
    coc-emmet
    coc-snippets
    coc-git
    coc-svg
    coc-angular
    coc-vimlsp
    coc-markdownlint
    coc-webpack
    coc-prettier
  ])
end

def main
  subtitle 'Installing Vim, the best test editor in the world ...'
  install_vim

  subtitle 'Cloning my dotvim Github repository ...'
  install_dotvim

  subtitle 'Installing Vim Plugins ...'
  install_vim_plugins

  subtitle 'Installing Coc.nvim sources ...'
  install_coc_nvim_sources
end

main
