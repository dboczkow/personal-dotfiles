#!/usr/bin/env bash

#   ____                            _                 _           
#  |  _ \  ___ _ __   ___ _ __   __| | ___ _ __   ___(_) ___  ___ 
#  | | | |/ _ \ '_ \ / _ \ '_ \ / _` |/ _ \ '_ \ / __| |/ _ \/ __|
#  | |_| |  __/ |_) |  __/ | | | (_| |  __/ | | | (__| |  __/\__ \
#  |____/ \___| .__/ \___|_| |_|\__,_|\___|_| |_|\___|_|\___||___/
#             |_|                                                 

echo "📦: Installing missing dependencies"

# Git
((! $+commands[git])) && sudo pacman -S --noconfirm git

# Paru
if ((! $+commands[paru])); then
  temp_dir=$(mktemp -d)
  git clone https://aur.archlinux.org/paru-git.git "$temp_dir"
  cd "$temp_dir" || exit 1
  makepkg -si --noconfirm
  cd
  rm -rf "$temp_dir"
fi

# PowerLevel10k
if [[ ! -f ~/.config/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme]]; then
  git clone --depth=1 https://github.com/romkatv/prowerlevel10k ~/.config/zsh/themes/powerlevel10k/
fi

# FZF
(( ! $+commands[fzf])) && sudo pacman -S --noconfirm fzf

# Node Version Manager
(( ! $+commands[nvm])) && sudo pacman -S --noconfirm nvm

# Tmux
(( ! $+commands[tmux])) && sudo pacman -S --noconfirm tmux

# Tmux Plugin Manager
if [[ ! -f ~/.tmux/plugins/tpm/tpm]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# LSD
(( ! $+commands[lsd])) && sudo pacman -S --noconfirm lsd

# Bat
(( ! $+commands[bat])) && sudo pacman -S --noconfirm bat

# rsync
(( ! $+commands[rsync])) && sudo pacman -S --noconfirm rsync

# sshs
(( ! $+commands[sshs])) && sudo pacman -S --noconfirm sshs

# glow
(( ! $+commands[glow])) && paru -S --noconfirm glow-git

# FZF-tab
if [[ ! -f ~/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh]]; then
  git clone https://github.com/Aloxaf/fzf-tab ~/.config/zsh/plugins/fzf-tab/
fi

# Fuzzy-sys
if [[ ! -f ~/.config/zsh/plugins/fuzzy-sys/fuzzy-sys.plugin.zsh]]; then
  git clone https://github.com/NullSense/fuzzy-sys.git ~/.config/zsh/plugins/fuzzy-sys/
fi

# Fast syntax highlighting
if [[ ! -f ~/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh]]; then
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.config/zsh/plugins/fast-syntax-highlighting/
fi

# Neovim
((! $+commands[nvim])) && sudo pacman -S --noconfirm neovim

# yazi
((! $+commands[ya])) && paru -S --noconfirm yazi-git
