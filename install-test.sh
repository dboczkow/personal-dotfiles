#!/usr/bin/env bash

set -e

REPO_NAME="personal-dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"
AUR_HELPER=""

echo "=== Dotfiles Installer ==="

if [[ "$(basename "$PWD")" == "$REPO_NAME" ]]; then
    echo "Renaming $REPO_NAME to .dotfiles..."
    cd ..
    mv "$REPO_NAME" "$DOTFILES_DIR"
    cd "$DOTFILES_DIR"
elif [[ "$(basename "$PWD")" == ".dotfiles" ]]; then
    DOTFILES_DIR="$PWD"
    echo "Already in .dotfiles directory"
else
    echo "Error: Run this script from personal-dotfiles or .dotfiles directory"
    exit 1
fi

echo "Detecting AUR helper..."
if command -v paru &>/dev/null; then
    AUR_HELPER="paru"
elif command -v yay &>/dev/null; then
    AUR_HELPER="yay"
else
    echo "Error: No AUR helper found (paru or yay)"
    exit 1
fi
echo "Using: $AUR_HELPER"

echo "Installing dependencies..."
pacman_packages=(bat btop fastfetch kitty neovim ohmyposh posting tmux yazi zsh curl luarocks tree-sitter-cli python-pylatexenc libtexprintf biber xdotool)

for pkg in "${pacman_packages[@]}"; do
    if ! pacman -Q "$pkg" &>/dev/null; then
        echo "Installing $pkg..."
        sudo "$AUR_HELPER" -S --needed "$pkg"
    else
        echo "$pkg already installed"
    fi
done

echo "Creating symlinks with stow..."
stow -v -t "$HOME" -d "$DOTFILES_DIR" .config .zshrc .gitmux.conf .scripts

echo "=== Installation complete ==="
