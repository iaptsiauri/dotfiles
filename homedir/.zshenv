# Read by every zsh, including non-interactive ones, so cargo is always on PATH.
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
