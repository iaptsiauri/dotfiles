#!/usr/bin/env bash

# Apps
apps=(
    1password
    1password-cli       # `op`; ~/.zshrc loads its shell plugins
    discord
    font-fira-code      # editor font (VS Code settings)
    ngrok
    orbstack            # Docker runtime; ~/.zshrc points DOCKER_HOST at it
    postico             # Postico 2, Postgres GUI
    visual-studio-code
    whatsapp
)

brew install --cask "${apps[@]}"
