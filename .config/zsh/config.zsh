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

### Start with fastfetch on start for SWAG ###
# fastfetch
