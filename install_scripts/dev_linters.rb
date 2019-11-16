#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/helpers'

def install_linters
  # -------------------------------------------------------------------------- #
  # => HTML, CSS
  # -------------------------------------------------------------------------- #
  subtitle 'Installing Stylelint'
  install_npm(
    global: ['stylelint']
  )

  subtitle 'Installing HTMLhint'
  install_npm(
    global: ['htmlhint']
  )

  # -------------------------------------------------------------------------- #
  # => JavaScript
  # -------------------------------------------------------------------------- #
  subtitle 'Installing ESLint ...'
  install_npm(
    global: ['eslint']
  )

  subtitle 'Installing Prettier ...'
  install_npm(
    global: ['prettier']
  )

  subtitle 'Installing JSONLint ...'
  install_npm(
    global: ['jsonlint']
  )

  # GraphQL
  subtitle 'Installing GQLint for GraphQL ...'
  install_npm(
    global: ['gqlint']
  )

  subtitle 'Installing Handlebars Lint ...'
  install_npm(
    global: ['ember-template-lint']
  )

  subtitle 'Installing Pug-Lint ...'
  install_npm(
    global: ['pug-lint']
  )

  # -------------------------------------------------------------------------- #
  # => Python
  # -------------------------------------------------------------------------- #
  subtitle 'Installing Pylint ...'
  install_pip(
    global: ['pylint']
  )

  subtitle 'Installing Flake8 ...'
  install_pip(
    global: ['flake8']
  )

  # -------------------------------------------------------------------------- #
  # => Ruby
  # -------------------------------------------------------------------------- #
  subtitle 'Installing Rubocop and Solargraph ...'
  install_gem(
    global: %w[
      solargraph
      rubocop
    ]
  )

  # Prettier Ruby Support
  install_gem(
    global: ['prettier']
  )

  subtitle 'Installing HAML_Lint'
  install_gem(
    global: %w[
      haml_lint
    ]
  )
  # -------------------------------------------------------------------------- #
  # => Markdown
  # -------------------------------------------------------------------------- #
  # subtitle 'Installing MarkdownLint ...'
  # install_gem(
  #   global: %w[
  #     mdl
  #   ]
  # )

  subtitle 'Installing Remark-lint'
  install_npm(
    global: ['remark-lint']
  )

  # -------------------------------------------------------------------------- #
  # => Shell
  # -------------------------------------------------------------------------- #
  subtitle 'Installing ShellCheck ...'
  install_packages(
    snap: ['shellcheck']
  )

  # -------------------------------------------------------------------------- #
  # => Git config message
  # -------------------------------------------------------------------------- #
  subtitle 'Installing Gitlint ...'
  install_pip(
    global: ['gitlint']
  )

  # -------------------------------------------------------------------------- #
  # => Vimscript
  # -------------------------------------------------------------------------- #
  subtitle 'Installing Vim-vint ...'
  install_pip(
    global: ['vim-vint']
  )

  # -------------------------------------------------------------------------- #
  # => Writing Helpers
  # -------------------------------------------------------------------------- #
  subtitle 'Installing Alex'
  install_npm(
    global: ['alex']
  )

  subtitle 'Install write-good ...'
  install_npm(
    global: ['write-good']
  )

  subtitle 'Install proselint ...'
  install_pip(
    global: ['proselint']
  )
end

def install_global_npm_packages
  subtitle 'Installing Yarn, a Fast and Reliable Dependency Manager ...'
  install_npm(
    global: ['yarn']
  )

  subtitle 'Installing Tern, Code-analysis engine for JavaScript ...'
  install_npm(
    global: ['tern']
  )

  subtitle 'Install Sass, a CSS Preprocessor ...'
  install_npm(
    global: ['sass']
  )

  subtitle 'Install JSCtags, a CTAGS generator for JS Sources ...'
  install_npm(
    global: [
      'git+https://github.com/ramitos/jsctags.git'
    ]
  )

  subtitle 'Install BrowserSync, a CTAGS generator for JS Sources ...'
  install_npm(
    global: ['browser-sync']
  )

  subtitle 'Install Commonmark, a superset of Markdown ...'
  install_npm(
    global: ['commonmark']
  )
end

def install_global_pip_packages
  install_pip(
    global: ['youtube-dl']
  )
end

# def install_global_gem_packages

# end

def main
  subtitle 'Installing Linters ... '
  install_linters

  subtitle 'Installing Global Packages ... '
  # install_global_gem_packages
  install_global_npm_packages
  install_global_pip_packages
end

main
