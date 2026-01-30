#  ____  _           _ _                 
# |  _ \(_)         | (_)                
# | |_) |_ _ __   __| |_ _ __   __ _ ___ 
# |  _ <| | '_ \ / _` | | '_ \ / _` / __|
# | |_) | | | | | (_| | | | | | (_| \__ \
# |____/|_|_| |_|\__,_|_|_| |_|\__, |___/
#                               __/ |    
#                              |___/     

## Disable some zsh functions ##

set -o ignoreeof # ignore ctrl-d to close terminal

## FZF functions ##

bindkey '^[[A' fzf-history-widget   # history search
bindkey "^F" fzf-file-widget        # find file
bindkey "^D" fzf-cd-widget

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^H" backward-kill-word
bindkey "^[[3;5~" kill-word
bindkey "^e^b" edit-command-line
