#   _____  _             _           
#  |  __ \| |           (_)          
#  | |__) | |_   _  __ _ _ _ __  ___ 
#  |  ___/| | | | |/ _` | | '_ \/ __|
#  | |    | | |_| | (_| | | | | \__ \
#  |_|    |_|\__,_|\__, |_|_| |_|___/
#                   __/ |            
#                  |___/             

# FZF Completion
source /home/msafro12/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# FZF
source <(fzf --zsh)

export FZF_DEFAULT_OPTS="--style full \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4"
export FZF_CTRL_T_OPTS="--preview '[[ -d {} ]] && lsd --color=always --icon=always --git --tree {} || bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'lsd --color=always --icon=always --tree {}| head -200'"

# Fuzzy-sys

source /home/msafro12/.config/zsh/plugins/fuzzy-sys/fuzzy-sys.plugin.zsh

# Fast syntax highlighting

source /home/msafro12/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# SDKMan
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/msafro12/.sdkman"
[[ -s "/home/msafro12/.sdkman/bin/sdkman-init.sh" ]] && source "/home/msafro12/.sdkman/bin/sdkman-init.sh"

# Node Version Manager

source /usr/share/nvm/init-nvm.sh

# Docker

export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

# Dotnet SDK

export PATH="$PATH:/home/msafro12/.dotnet/tools"

# Spicetify

export PATH=$PATH:/home/msafro12/.spicetify

# Tmux

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t Zeus || tmux new-session -s Zeus
fi
