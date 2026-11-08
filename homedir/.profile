#############################################################
# Generic configuration that applies to all shells
#############################################################

source ~/.shellfn

# Tool environments, each loaded only if that tool is installed
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"
