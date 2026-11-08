# Deno completions
if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then export FPATH="$HOME/.zsh/completions:$FPATH"; fi

# Plugins: antidote loads everything listed in ~/.zsh_plugins.txt
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load

# Personal aliases (ls -> eza, cat -> bat, ...). Run `alias` to list them all.
source ~/.shellaliases

eval "$(starship init zsh)"

# Tools installed into ~/.local/bin (uv and friends)
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# Up/Down search the history for what you've typed so far
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Switch Node version on cd to match a project's .nvmrc / .node-version
eval "$(fnm env --use-on-cd --shell zsh)"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
[[ -f "$HOME/.config/op/plugins.sh" ]] && source "$HOME/.config/op/plugins.sh"
[[ -f "$HOME/.deno/env" ]] && . "$HOME/.deno/env"

# Completions
autoload -Uz compinit
compinit

# Let Testcontainers connect to OrbStack's Docker socket.
[[ -d "$HOME/.orbstack" ]] && export DOCKER_HOST="unix://$HOME/.orbstack/run/docker.sock"

# bun completions
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# Machine-specific settings (work paths and the like). Not in the dotfiles repo.
# An if-block rather than `&&`, so a missing file doesn't leave the first
# prompt showing an error status.
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
