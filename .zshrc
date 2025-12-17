# Golang
export PATH="$PATH:$HOME/go/bin"

# show git branch in prompt
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_DEF=$'%f'
COLOR_USR=$'%F{243}'
COLOR_DIR=$'%F{197}'
COLOR_GIT=$'%F{39}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} $ '

# Local bin
export PATH="$HOME/.local/bin:$PATH"

# Direnv
# eval "$(direnv hook zsh)"

# Flutter SDK
export PATH=$HOME/flutter/bin:$PATH
