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
compinit

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
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

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

alias c='z'
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

alias reload='source ~/.zshrc'

alias update='sudo dnf update'

alias weather='curl wttr.in/Skowhegan'

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

# Fuzzy Finder
# ---------------
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --bind='ctrl-/:toggle-preview'"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -50'"
eval "$(fzf --zsh)"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Fuzzy branch switch
fbr() {
    local branch
    branch=$(
        git branch --all |
        grep -v HEAD |
        fzf --preview "git log --oneline --color=always {1}"
    )

    branch=${branch#remotes/origin/}
    branch=${branch#* }

    [[ -n "$branch" ]] && git checkout "$branch"
}

# Fuzzy open in Neovim
fv() {
    local file
    file=$(fd --type f | fzf --preview 'bat --color=always --style=numbers {}')
    [[ -n "$file" ]] && "$EDITOR" "$file"
}

# Fuzzy cd into any subdirectory
fcd() {
  local dir
  dir=$(fd --type d | fzf --preview 'eza --tree --color=always {} | head -30')
  [ -n "$dir" ] && cd "$dir"
}

# Kill a process interactively
fkill() {
  local pid
  pid=$(ps aux | sed 1d | fzf -m | awk '{print $2}')
  [ -n "$pid" ] && echo "$pid" | xargs kill -${1:-15}
}

# zoxide change directory command
eval "$(zoxide init zsh)"
