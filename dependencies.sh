#!/usr/bin/env bash

#   ____                            _                 _           
#  |  _ \  ___ _ __   ___ _ __   __| | ___ _ __   ___(_) ___  ___ 
#  | | | |/ _ \ '_ \ / _ \ '_ \ / _` |/ _ \ '_ \ / __| |/ _ \/ __|
#  | |_| |  __/ |_) |  __/ | | | (_| |  __/ | | | (__| |  __/\__ \
#  |____/ \___| .__/ \___|_| |_|\__,_|\___|_| |_|\___|_|\___||___/
#             |_|                                                 

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
  git clone https://github.com/romkatv/prowerlevel10k ~/.config/zsh/themes/powerlevel10k/
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
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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
  git clone https://github.com/Aloxaf/fzf-tab ~/.config/zsh/plugins/fzf-tab/
fi

# Fuzzy-sys
if [[ ! -f ~/.config/zsh/plugins/fuzzy-sys/fuzzy-sys.plugin.zsh ]]; then
  git clone https://github.com/NullSense/fuzzy-sys.git ~/.config/zsh/plugins/fuzzy-sys/
fi

# Fast syntax highlighting
if [[ ! -f ~/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.config/zsh/plugins/fast-syntax-highlighting/
fi

# Neovim
if ! command -v nvim &> /dev/null; then
  sudo pacman -S --noconfirm neovim
fi

# yazi
if ! command -v ya &> /dev/null; then
  paru -S --noconfirm yazi-git
fi
