# Dotfiles

My Mac setup: zsh with [antidote](https://antidote.sh) plugins and a
[starship](https://starship.rs) prompt, git config, VS Code settings, and a
setup script for a new machine.

## Install

```sh
git clone git@github.com:iaptsiauri/dotfiles.git
cd dotfiles
./install.sh
```

The script asks for your sudo password once and then:

1. Applies macOS settings (`system/macos.sh`): keyboard repeat, Finder, Dock,
   screenshots, firewall.
2. Optionally replaces `/etc/hosts` with the latest ad-blocking list from
   someonewhocares.org, keeping a backup.
3. Installs Homebrew if it's missing.
4. Symlinks everything in `homedir/` into `~`, and `starship/starship.toml`
   into `~/.config`. Existing files are moved to `~/.dotfiles_backup/<date>/`.
5. Installs command-line tools (`install/brew.sh`) and apps
   (`install/brew_cask.sh`).
6. Installs Rust with rustup, plus clippy, rustfmt and rust-analyzer.
7. Installs the latest Node LTS with fnm.
8. Links the VS Code settings and installs the extensions in
   `vscode/extensions.txt`.

Because the files in `~` are symlinks into this repo, changes you make to them
show up here, ready to commit.

## Machine-specific settings

Put anything that only applies to one machine, such as work paths and project
environment variables, in `~/.zshrc.local`. `.zshrc` sources it if it exists,
and it is not part of this repo.
