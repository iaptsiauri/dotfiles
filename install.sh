#!/usr/bin/env bash

# Sets up a Mac: macOS settings, Homebrew tools and apps, Rust, Node, VS Code,
# and symlinks from ~ to the config files in this repo.
# Clone the repo anywhere and run ./install.sh from it.

# Work from the repo's own directory, wherever it was cloned
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES" || exit 1

# include my library helpers for colorized echo
source ./lib_sh/echos.sh

bot "Hi! I'm going to install tooling and tweak your system settings. Here I go..."

# Ask for the administrator password upfront
bot "I need you to enter your sudo password so I can install some things:"
sudo -v

# Keep-alive: update existing sudo time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

bot "Configuring MacOS system settings..."
source ./system/macos.sh

#####
# /etc/hosts
#####

read -r -p "Replace /etc/hosts with the latest ad-blocking hosts file from someonewhocares.org? [y|N] " response
if [[ $response =~ ^(yes|y|Y)$ ]]; then
    hosts_tmp=$(mktemp)
    action "downloading https://someonewhocares.org/hosts/hosts"
    if curl -fsSL https://someonewhocares.org/hosts/hosts -o "$hosts_tmp"; then
        sudo cp /etc/hosts /etc/hosts.backup
        sudo cp "$hosts_tmp" /etc/hosts
        ok
        bot "Your /etc/hosts file has been updated. The previous version is saved in /etc/hosts.backup"
    else
        error "download failed, /etc/hosts left unchanged"
    fi
    rm -f "$hosts_tmp"
fi

#####
# Homebrew
#####

running "checking homebrew install"
if ! command -v brew > /dev/null 2>&1; then
  action "installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # ~/.zprofile (linked below) runs `brew shellenv` for new shells; this is for the rest of this script
  if ! eval "$(/opt/homebrew/bin/brew shellenv)"; then
    error "unable to install homebrew, script $0 abort!"
    exit 2
  fi
else
  ok
  running "updating homebrew"
  brew update
  ok
  bot "before installing brew packages, we can upgrade any outdated packages."
  read -r -p "run brew upgrade? [y|N] " response
  if [[ $response =~ ^(y|yes|Y)$ ]]; then
      action "upgrade brew packages..."
      brew upgrade
      ok "brews updated..."
  else
      ok "skipped brew package upgrades.";
  fi
fi

#####
# Symlinks
#####

now=$(date +"%Y.%m.%d.%H.%M.%S")

# link <file in repo> <path in ~>: moves an existing real file aside, then symlinks
link() {
  local src=$1 dest=$2
  running "$dest"
  if [[ -e $dest && ! -L $dest ]]; then
    mkdir -p ~/.dotfiles_backup/"$now"
    mv "$dest" ~/.dotfiles_backup/"$now"/
    echo "backup saved as ~/.dotfiles_backup/$now/$(basename "$dest")"
  fi
  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
  echo -en '\tlinked';ok
}

bot "creating symlinks for project dotfiles..."
for file in "$DOTFILES"/homedir/.*; do
  name=$(basename "$file")
  [[ $name == "." || $name == ".." ]] && continue
  link "$file" ~/"$name"
done
link "$DOTFILES/starship/starship.toml" ~/.config/starship.toml

#####
# Tools and apps
#####

bot "installing packages with brew..."
source ./install/brew.sh

bot "installing apps with brew cask..."
source ./install/brew_cask.sh

#####
# Rust
#####

bot "Installing Rust with rustup..."
if ! command -v rustup > /dev/null 2>&1; then
  # --no-modify-path: ~/.zshenv and ~/.profile (linked above) already load ~/.cargo/env
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi
source "$HOME/.cargo/env"
rustup component add clippy rustfmt rust-analyzer rust-src
ok

#####
# Node
#####

bot "Installing the latest LTS version of Node with fnm..."
fnm install --lts
eval "$(fnm env --shell bash)"

bot "configuring npm..."
source ./install/npm.sh

#####
# VS Code
#####

bot "Setting up VS Code..."
link "$DOTFILES/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
running "installing the extensions listed in vscode/extensions.txt"
while read -r ext; do
  [[ -n $ext ]] && code --install-extension "$ext" < /dev/null > /dev/null
done < ./vscode/extensions.txt
ok

bot "All done! Open a new terminal window to load the new shell config."
bot "Put machine-specific shell settings (work paths and the like) in ~/.zshrc.local."
