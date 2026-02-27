#!/usr/bin/env bash

#   ___           _        _ _ 
#  |_ _|_ __  ___| |_ __ _| | |
#   | || '_ \/ __| __/ _` | | |
#   | || | | \__ \ || (_| | | |
#  |___|_| |_|___/\__\__,_|_|_|
#

dependencies=("bat","btop","fastfetch","kitty","neovim","ohmyposh","posting","tmux","yazi","zsh","curl","luarocks","tree-sitter-cli","python-pylatexenc","libtexprintf","biber","xdotool")
plugins=("tpm", "fast-syntax-highlighting", "fuzzy-sys", "fzf-tab")

check_missing_packages() {
  local -n pkgs="$1"
  local missing=()

  for pkg in "${pkgs[@]}"; do
    if ! pacman -Q "$pkg" &> /dev/null; then
      missing+=("$pkg")
    fi
  done

  if [ ${#missing[@]} -eq 0 ]; then
    echo ""
  else
    printf "%s\n" "${missing[*]}"
  fi
}

install() {
  echo ": Installing missing dependencies"
  missing=$(check_missing_packages dependencies)
  echo $missing
  exit 0
}

echo "Do you see this this checkbox: "
read -n 1 -p "[y/N]: " choice
echo ""

case $choice in 
  [Yy] )  install ;;
  [Nn] )  echo -e "\e[93m⚠️ To continue install nerd-font package from pacman!!"
          exit 1
          ;;
  *)      exit 1
          ;;
esac


