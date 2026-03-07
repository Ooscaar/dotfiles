#!/usr/bin/env zsh

################################################################################
# PATH CONFIGURATION - All path entries consolidated
################################################################################
typeset -U path PATH
path=(
	"$HOME/.local/bin"
	"$HOME/bin"
	"$HOME/.cargo/bin"
	"/usr/local/bin"
	"$HOME/.fly/bin"
	"/usr/local/go/bin"
	"$HOME/.bun/bin"
	"$HOME/.local/share/pnpm"
	"$HOME/.opencode/bin"
	"$HOME/.lmstudio/bin"
	$path
)

# Tool-specific exports
export FLYCTL_INSTALL="$HOME/.fly"
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/.local/share/pnpm"

################################################################################
# OH-MY-ZSH CONFIGURATION
################################################################################
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="afowler"

# Disable auto-updates for faster startup
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"

# Plugins - keep minimal for performance
plugins=(
	git
	docker
	docker-compose
)

source $ZSH/oh-my-zsh.sh

################################################################################
# ZSH PLUGINS (External)
################################################################################
if [ -f ~/.zsh/plugins.zsh ]; then
	source ~/.zsh/plugins.zsh
fi

################################################################################
# COMPLETION SYSTEM - Optimized with caching
################################################################################
# Use completion cache to speed up startup (regenerate daily)
autoload -Uz compinit
zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -n ${zcompdump}(#qN.mh+24) ]]; then
	compinit
else
	compinit -C
fi

# Bash completions
autoload -U +X bashcompinit && bashcompinit
if command -v terraform >/dev/null 2>&1; then
	complete -o nospace -C /usr/bin/terraform terraform
fi

################################################################################
# ENVIRONMENT VARIABLES
################################################################################
export EDITOR='vi'

# Secrets
if [ -f ~/.secrets.zsh ]; then
    source ~/.secrets.zsh
fi

################################################################################
# ALIASES
################################################################################
# Config shortcuts
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
alias tmuxconfg="vim ~/.tmux.conf"
alias tmuxconfig="vim ~/.tmux.conf"

# Git shortcuts
alias gits="git status"
alias gitp="git push"

# Common tools
alias cat="bat"
alias k="kubectl"

################################################################################
# LAZY-LOADED KUBECTL COMPLETION (Performance optimization)
################################################################################
# Kubectl completion is very slow, so lazy load it on first use
kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
    fi
    command kubectl "$@"
}

################################################################################
# PROMPT AND TOOLS INITIALIZATION
################################################################################
# Starship prompt
if command -v starship >/dev/null 2>&1; then
	eval "$(starship init zsh)"
fi

# Mise (runtime manager)
if [ -x /usr/bin/mise ]; then
	eval "$(/usr/bin/mise activate zsh)"
fi

# Atuin (shell history)
if [ -f "$HOME/.atuin/bin/env" ]; then
	. "$HOME/.atuin/bin/env"
fi
if command -v atuin >/dev/null 2>&1; then
	eval "$(atuin init zsh --disable-up-arrow)"
fi

################################################################################
# GOOGLE CLOUD SDK
################################################################################
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
    . "$HOME/google-cloud-sdk/path.zsh.inc"
fi

if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
    . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

################################################################################
# BUN COMPLETIONS
################################################################################
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

################################################################################
# CUSTOM INIT
################################################################################
if [ -f "$HOME/.local/try.rb" ]; then
	eval "$(ruby "$HOME/.local/try.rb" init "$HOME/src/tries")"
fi

# bun completions
[ -s "/home/operez/.bun/_bun" ] && source "/home/operez/.bun/_bun"
