#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)

function initialize () {
    # Source Prezto.
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

    # nvm setting
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

    # goenv setting
    export GOENV_ROOT="$HOME/.goenv"
    export PATH="$GOENV_ROOT/bin:$PATH"
    eval "$(goenv init -)"
    export PATH="$GOROOT/bin:$PATH"
    export PATH="$PATH:$GOPATH/bin"

    #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
}

function update_brew () {
    brew update
    brew outdated
    brew upgrade
    brew cleanup
}

function update_sdkman () {
    sdk selfupdate force
}

# nvm: https://github.com/nvm-sh/nvm
function update_nvm () {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
}

# Prezto: https://github.com/sorin-ionescu/prezto
function update_prezto () {
    cd ~/.zprezto
    git pull
    git submodule sync --recursive
    git submodule update --init --recursive
    cd $SCRIPT_DIR
}

# goenv: https://github.com/syndbg/goenv
function update_goenv () {
    cd $GOENV_ROOT
    git pull origin master
    cd $SCRIPT_DIR
}

 function update_rustup() {
    rustup self update
 }

function update_text () {
    printf "\033[32m%s\033[m\n" ">>> Updating $1"
}

function main () {
    initialize
    update_text "Homebrew"
    update_brew
    update_text "SDKMAN!"
    update_sdkman
    # update_text "nvm"
    # update_nvm
    update_text "Prezto"
    update_prezto
    update_text "goenv"
    update_goenv
    update_text "cargo"
    update_rustup
}

if [ "$(uname)" == 'Darwin' ]; then
    # mac
    main
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    # linux
    echo "Linux OS is not support."
    exit 1
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
    # win
    echo "Windows OS is not support."
    exit 1
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi
