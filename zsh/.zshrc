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
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY

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
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C  # skip check if dump is less than 24h old
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # colored completion menu
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'  # category headers
zstyle ':completion:*' squeeze-slashes true  # foo//bar becomes foo/bar

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
export PATH="$PATH:/home/jaredperkins/bin:/home/jaredperkins/.local/bin"

# ------------------------------
# Aliases
# ------------------------------

alias ls='eza --icons'
alias ll='eza -lh --icons --git'
alias la='eza -lah --icons --git'
alias lt='eza --tree --icons -L 2'
alias lt3='eza --tree --icons -L 3'
alias lta='eza --tree --icons -a -L 2'
alias ld='eza -lhD --icons'
alias lS='eza -lh --icons --git -s size'
alias lm='eza -lh --icons --git -s modified'

alias cd='z'
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
# Useful functions
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

eval "$(zoxide init zsh)"
