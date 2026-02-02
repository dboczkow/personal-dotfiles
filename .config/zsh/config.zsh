#  __  __       _          _____             __ _       
# |  \/  |     (_)        / ____|           / _(_)      
# | \  / | __ _ _ _ __   | |     ___  _ __ | |_ _  __ _ 
# | |\/| |/ _` | | '_ \  | |    / _ \| '_ \|  _| |/ _` |
# | |  | | (_| | | | | | | |___| (_) | | | | | | | (_| |
# |_|  |_|\__,_|_|_| |_|  \_____\___/|_| |_|_| |_|\__, |
#                                                  __/ |
#                                                 |___/ 
#

### Check if base stuff is installed, if not install them ###
((! $+commands[git])) && sudo pacman -S --noconfirm git
if ((! $+commands[paru])); then
  temp_dir=$(mktemp -d)
  git clone https://aur.archlinux.org/paru-git.git "$temp_dir"
  cd "$temp_dir" || exit 1
  makepkg -si --noconfirm
  cd 
  rm -rf "$temp_dir"
fi

HISTFILE=~/.cache/zshhistfile
HISTSIZE=9999
SAVEHIST=99999
setopt autocd beep extendedglob nomatch notify
bindkey -e
autoload -Uz compinit  
autoload -Uz edit-command-line
zle -N edit-command-line
compinit


### Theme ###
source ~/.config/zsh/themes/theme.zsh

## Plugins ##
source /home/msafro12/.config/zsh/plugins/plugins.zsh

## Binds ##
source /home/msafro12/.config/zsh/binds.zsh

## Aliases ##
source /home/msafro12/.config/zsh/aliases.zsh

## Hooks ##
source /home/msafro12/.config/zsh/hooks.zsh

### Start with fastfetch on start ###
fastfetch
