#           _ _                     
#     /\   | (_)                    
#    /  \  | |_  __ _ ___  ___  ___ 
#   / /\ \ | | |/ _` / __|/ _ \/ __|
#  / ____ \| | | (_| \__ \  __/\__ \
# /_/    \_\_|_|\__,_|___/\___||___/
#                                                                     
#

move_files() {
    rsync -rlkHpXogtUhm --specials --info=progress2 --remove-source-files "$1" "$2"
    find $1 -type d -empty -delete
}

## Aliases ##
alias ls="lsd -A"
alias l="lsd"
alias ll="lsd -l"
alias lt="lsd --tree"
alias cat="bat"
alias df="duf"
alias cp="rsync -rlkHpXogtUh --specials --info=progress2 "$1" "$2""
alias mv="move_files"
alias tree="lsd --tree"
alias daemons="fuzzy-sys"
alias ping="gping --clear"
alias postman="posting"
## Suffix Aliases ##
alias -s md="glow -p"

alias vi="nvim"
alias vim="nvim"
