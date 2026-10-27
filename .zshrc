# PATH Variables
# export PATH=/opt/homebrew/bin:$PATH

# ENVIRONMENT
export LOCAL_DEV=true
export DESKTOP="/mnt/c/Users/Slim 5/Desktop/"
export PATH="$HOME/.local/bin:$PATH"


# Shell integrations
# eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"
eval "$(zoxide init --cmd cd zsh)"

# -----ZINIT CONFIG-----
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Run p10k configure or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Zinit plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Snippet plugins
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::gcloud
zinit snippet OMZP::golang
zinit snippet OMZP::kubectl
zinit snippet OMZP::docker
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e

function accept-or-history-up() {
  if [[ -n $ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE ]]; then
    zle autosuggest-accept
  else
    zle history-search-backward
  fi
}
zle -N accept-or-history-up

typeset -g _hp_len _hp_last
_history_prefix_search() {
  local dir=$1
  if [[ $LASTWIDGET == _history_prefix_up || $LASTWIDGET == _history_prefix_down ]] &&
     [[ $BUFFER == $_hp_last ]]; then
    CURSOR=$_hp_len
  else
    _hp_len=$CURSOR
  fi
  zle history-beginning-search-$dir
  _hp_last=$BUFFER
  zle end-of-line
}
_history_prefix_up()   { _history_prefix_search backward }
_history_prefix_down() { _history_prefix_search forward }
zle -N _history_prefix_up
zle -N _history_prefix_down

# Two encodings are bound because terminals send either CSI (^[[A) or
# SS3 (^[OA, "application cursor keys" mode) for the arrow keys.
bindkey '^[[A' _history_prefix_up    # Up arrow (CSI)
bindkey '^[OA' _history_prefix_up    # Up arrow (SS3 / app mode)
bindkey '^[[B' _history_prefix_down  # Down arrow (CSI)
bindkey '^[OB' _history_prefix_down  # Down arrow (SS3 / app mode)
# bindkey '^[[C' autosuggest-accept       # Right arrow

# History
HISTSIZE=100000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# LS colors: directories = light blue
export LS_COLORS="di=1;94"

# ZStyle config
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
# zstyle ':completion:*' menu select=1

# Aliases
alias ls='ls --color'
alias l='ls -lah --color'
alias p3='python3.12'
alias la='ls -a --color'
alias vim='nvim'
alias c='clear'
alias desktop='cd $DESKTOP'
alias de='cd $DESKTOP'
# alias gcloud='~/.config/google-cloud-sdk/bin/gcloud'

# Wezterm
if [ -n "$WEZTERM_PANE" ]; then
    export TERM=xterm-kitty
    export TERMINAL_EMULATOR=wezterm
fi

# Tmux conf

. "$HOME/.local/bin/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/shres/.bun/_bun" ] && source "/home/shres/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/Odin:$PATH"

# opencode
export PATH=/home/shres/.opencode/bin:$PATH
