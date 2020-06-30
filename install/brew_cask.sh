#!/usr/bin/env bash

# Install packages
apps=(
    1password
    dropbox
    docker
    iterm2
    visual-studio-code
    opera
    google-chrome
    spotify
    slack
    shiftit
    the-unarchiver
)

brew cask install "${apps[@]}"