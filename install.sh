#!/usr/bin/env bash

#   ___           _        _ _ 
#  |_ _|_ __  ___| |_ __ _| | |
#   | || '_ \/ __| __/ _` | | |
#   | || | | \__ \ || (_| | | |
#  |___|_| |_|___/\__\__,_|_|_|
#


cd ..
mv personal-dotfiles $HOME/.dotfiles

cd $HOME/.dotfiles

echo "⬆️: Update mirrors and system"

sudo pacman -Syyuu --noconfirm

echo "🙈: Installing stow"

sudo pacman -S --noconfirm stow

stow .

echo "📦: Installing missing dependencies"

# Git
if ! command -v git &> /dev/null; then 
  sudo pacman -S --noconfirm git
fi

# Paru
if ! command -v paru &> /dev/null; then
  temp_dir=$(mktemp -d)
  git clone https://aur.archlinux.org/paru-git.git "$temp_dir"
  cd "$temp_dir" || exit 1
  makepkg -si --noconfirm
  cd
  rm -rf "$temp_dir"
fi

# PowerLevel10k
if [[ ! -f ~/.config/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k ~/.config/zsh/themes/powerlevel10k/ 
fi

# FZF
if ! command -v fzf &> /dev/null; then 
  sudo pacman -S --noconfirm fzf
fi

# Node Version Manager
if ! command -v nvm &> /dev/null; then 
 sudo pacman -S --noconfirm nvm
fi

# Tmux
if ! command -v tmux /dev/null; then
 sudo pacman -S --noconfirm tmux
fi

# Tmux Plugin Manager
if [[ ! -f ~/.tmux/plugins/tpm/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
fi

# LSD
if ! command -v lsd &> /dev/null;then 
  sudo pacman -S --noconfirm lsd
fi

# Bat
if ! command -v bat &> /dev/null;then
  sudo pacman -S --noconfirm bat
fi

# rsync
if ! command -v rsync &> /dev/null; then 
  sudo pacman -S --noconfirm rsync
fi

# sshs
if ! command -v sshs &> /dev/null; then
  sudo pacman -S --noconfirm sshs
fi

# glow
if ! command -v glow &> /dev/null; then
  paru -S --noconfirm glow-git
fi

# FZF-tab
if [[ ! -f ~/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh ]]; then
  git clone https://github.com/Aloxaf/fzf-tab.git ~/.config/zsh/plugins/fzf-tab/
fi

# Fuzzy-sys
if [[ ! -f ~/.config/zsh/plugins/fuzzy-sys/fuzzy-sys.plugin.zsh ]]; then
  git clone https://github.com/NullSense/fuzzy-sys.git ~/.config/zsh/plugins/fuzzy-sys/
fi

# Fast syntax highlighting
if [[ ! -f ~/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.config/zsh/plugins/fast-syntax-highlighting/
fi

# Neovim
if ! command -v nvim &> /dev/null; then
  sudo pacman -S --noconfirm neovim
fi

# yazi
if ! command -v ya &> /dev/null; then
  paru -S --noconfirm yazi-git
fi

# tesseract
if ! command -v tesseract &> /dev/null; then
  paru -S --noconfirm tesseract tesseract-data-eng tesseract-data-osd tesseract-data-pol
fi

# wl-copy
if ! command -v wl-copy &> /dev/null; then
  paru -S --noconfirm wl-clipboard
fi

# fastfetch (for swag)
if ! command -v fastfetch &> /dev/null; then
  paru -S --noconfirm fastfetch
fi

# fd
if ! command -v fd &> /dev/null; then
  paru -S --noconfirm fd
fi
