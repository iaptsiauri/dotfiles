#!/usr/bin/env bash

# Command-line tools. install.sh has already run `brew update`, and
# `brew upgrade` if you said yes.

apps=(
    antidote        # zsh plugin manager, reads ~/.zsh_plugins.txt
    bat             # cat with syntax highlighting (aliased to cat, git pager)
    coreutils       # GNU ls, date, sed... as gls, gdate, gsed
    eza             # ls replacement (aliased to ls)
    fnm             # Node version manager
    gh              # GitHub CLI
    git
    httpie          # `http` / `https` HTTP client
    ripgrep         # rg: fast code search
    rtk             # token-saving CLI proxy used by Claude Code hooks
    starship        # prompt
    tree            # used by the `tre` function
    wifi-password
)

brew install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup
