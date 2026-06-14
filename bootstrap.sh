#!/usr/bin/env bash
set -e

DOTFILES_REPO="https://github.com/YOUR_USER/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

echo "==> Installing dotfiles..."

# ----------------------------
# Clone or update repo
# ----------------------------
if [ -d "$DOTFILES_DIR" ]; then
    echo "==> Dotfiles already exist, pulling latest..."
    git -C "$DOTFILES_DIR" pull
else
    echo "==> Cloning dotfiles..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

# ----------------------------
# Install stow if missing
# ----------------------------
if ! command -v stow >/dev/null 2>&1; then
    echo "==> Installing GNU Stow..."
    
    if command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm stow
    elif command -v apt >/dev/null 2>&1; then
        sudo apt install -y stow
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y stow
    else
        echo "ERROR: No supported package manager found."
        exit 1
    fi
fi

# ----------------------------
# Stow packages
# ----------------------------
echo "==> Stowing configs..."

stow -D zsh 2>/dev/null || true
stow -D kitty 2>/dev/null || true
stow -D starship 2>/dev/null || true
stow -D git 2>/dev/null || true
stow -D zoxide 2>/dev/null || true

stow zsh
stow kitty
stow starship
stow git
stow zoxide

# ----------------------------
# Optional: zsh as default shell
# ----------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "==> Setting Zsh as default shell..."
    chsh -s "$(which zsh)" || true
fi

echo ""
echo "==> Done!"
echo "Restart your terminal or run: exec zsh"