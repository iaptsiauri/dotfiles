#!/usr/bin/env bash

# Install packages
apps=(
    docker
    visual-studio-code
    spotify
    shiftit
    the-unarchiver
)

brew list --cask "${apps[@]}" || brew install --cask "${apps[@]}"
