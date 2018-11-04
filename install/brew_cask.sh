#!/usr/bin/env bash

# Install packages
apps=(
    1password
    dropbox
    docker
    iterm2
    visual-studio-code
    firefox
    google-chrome
    spotify
    skype
    slack
    shiftit
    the-unarchiver
)

brew cask install "${apps[@]}"