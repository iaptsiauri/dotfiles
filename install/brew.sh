#!/usr/bin/env bash

# Installs Homebrew and some of the common dependencies needed/desired for software development

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

apps=(
    ack
    nvm
    coreutils
    git
    tree
    wifi-password
)

brew install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup