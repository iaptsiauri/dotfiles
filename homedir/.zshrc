
# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/ilia/.zsh/completions:"* ]]; then export FPATH="/Users/ilia/.zsh/completions:$FPATH"; fi

# Load Antidote zsh package manager
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# Personal aliases (ls -> eza, cat -> bat, ...). Run `alias` to list them all.
source ~/.shellaliases

eval "$(starship init zsh)"


. "$HOME/.local/bin/env"
export PATH=/Users/ilia/Documents/monorepo/bin:$PATH
export DJANGO_SETTINGS_MODULE=config.settings.dev


bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Autoload project Node Version
eval "$(fnm env --use-on-cd --shell zsh)"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
source /Users/ilia/.config/op/plugins.sh
. "/Users/ilia/.deno/env"
# Initialize zsh completions (added by deno install script)
autoload -Uz compinit
compinit

# Pi
export PATH="/Users/ilia/.local/share/fnm/node-versions/v24.15.0/installation/bin:$PATH"

# Let Testcontainers connect to OrbStack's Docker socket.
export DOCKER_HOST="unix://$HOME/.orbstack/run/docker.sock"

# bun completions
[ -s "/Users/ilia/.bun/_bun" ] && source "/Users/ilia/.bun/_bun"
