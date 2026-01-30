#  _______ _                         
# |__   __| |                        
#    | |  | |__   ___ _ __ ___   ___ 
#    | |  | '_ \ / _ \ '_ ` _ \ / _ \
#    | |  | | | |  __/ | | | | |  __/
#    |_|  |_| |_|\___|_| |_| |_|\___|
#                                                                       


# Powerlevel10k
if [[ ! -f ~/.config/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme]]; then
  git clone --depth=1 https://github.com/romkatv/prowerlevel10k.git ~/.config/zsh/themes/
fi

source /home/msafro12/.config/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/p10config.zsh.
[[ ! -f ~/.config/zsh/themes/p10config.zsh ]] || source ~/.config/zsh/themes/p10config.zsh
 

## CLI themes ##
# Bat
BAT_THEME="Catppuccin Mocha"
