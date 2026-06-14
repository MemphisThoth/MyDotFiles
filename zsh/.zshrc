# --------------------------
# History
# --------------------------

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# ---------------------------
# Navigation
# ---------------------------

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# ---------------------------
# Completion
# ---------------------------

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ----------------------------
# Keybindings
# ----------------------------

bindkey -e

# Ctrl+Left / Ctrl+Right word navigation
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# -----------------------------
# Environment
# -----------------------------

export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# ------------------------------
# Aliases
# ------------------------------

alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'

alias ..='cd ..'
alias ...='cd ../..'

alias grep='grep --color=auto'

# git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# --------------------
# USeful functions
# --------------------

mkcd() {
    mkdir -p "$1" && cd "$1"
}

extract() {
    case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz)  tar xzf "$1" ;;
        *.bz2)     bunzip2 "$1" ;;
        *.rar)     unrar x "$1" ;;
        *.gz)      gunzip "$1" ;;
        *.tar)     tar xf "$1" ;;
        *.zip)     unzip "$1" ;;
        *) echo "Cannot extract $1" ;;
    esac
}

# -----------------------
# Starship prompt
# -----------------------

eval "$(starship init zsh)"

# -----------------------
# Plugins
# -----------------------

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh