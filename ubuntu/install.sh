#! /bin/bash

function linuxbrew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
    test -r ~/.zshrc && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.zshrc
    echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
}

function linuxbrew_tools() {
    brew install git
    brew install lsd
    brew install vim
    brew install curl
}

function apply_zsh() {
    apt_update()

    sudo apt install zsh
    chsh -s $(which zsh)
}

function zprezto() {
    # require git.
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
}


function apt_update() {
    sudo apt update
    sudo apt upgrade
}

function goenv() {
    git clone https://github.com/syndbg/goenv.git ~/.goenv

    echo 'export GOENV_ROOT="$HOME/.goenv"' >> ~/.zshrc
    echo 'export PATH="$GOENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(goenv init -)"' >> ~/.zshrc
    echo 'export PATH="$GOROOT/bin:$PATH"' >> ~/.zshrc
    echo 'export PATH="$PATH:$GOPATH/bin"' >> ~/.zshrc
}

function monitoring_tool() {
    echo "grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /var/log/auth.log | grep -E 'Accepted' | cut -d ' ' -f 11 | sort | uniq" > ~/check_login.sh
    echo "sudo hddtemp /dev/sdc
          sudo hddtemp /dev/sdd" > ~/how_temp.sh
    echo "grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /var/log/auth.log | cut -d ' ' -f 10 | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort | uniq | wc -l" > ~/try_access.sh
    echo "grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /var/log/auth.log | cut -d ' ' -f 8 | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort | uniq -c | sort -nr" > ~/try_ip.sh
    echo " grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,4}' /var/log/auth.log | grep -E 'Invalid user' | cut -d ' ' -f 8 | sort | uniq -c | sort -nr" > ~/try_username.sh

    chmod +x ~/check_login.sh
    chmod +x ~/how_temp.sh
    chmod +x ~/try_access.sh
    chmod +x ~/try_ip.sh
    chmod +x ~/try_username.sh
}
