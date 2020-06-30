#!/usr/bin/env bash

# Install packages
apps=(
    docker
    hyper
    visual-studio-code
    spotify
    shiftit
    the-unarchiver
)

brew cask list "${apps[@]}" || brew cask install "${apps[@]}"
