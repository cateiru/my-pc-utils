# Ubuntu オレオレセットアップ

- Ubuntu: 20.04

## Index

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
- [Ubuntu オレオレセットアップ](#ubuntu-オレオレセットアップ)
  - [Index](#index)
  - [ホームディレクトリを英語に](#ホームディレクトリを英語に)
  - [Linuxbrew](#linuxbrew)
  - [Linuxbrew tools](#linuxbrew-tools)
  - [zsh](#zsh)
    - [prezto](#prezto)
  - [Vim](#vim)
  - [Docker](#docker)
  - [TODO](#todo)
    - [sshの公開鍵認証化](#sshの公開鍵認証化)
    - [gitのGitHubログイン（commitの認証）](#gitのgithubログインcommitの認証)
  - [TODO: 必要に応じて](#todo-必要に応じて)
    - [nvm](#nvm)
    - [goenv](#goenv)
    - [pyenv](#pyenv)
    - [モニタリングツール](#モニタリングツール)
  - [アプリケーション](#アプリケーション)
    - [Chrome](#chrome)

## ホームディレクトリを英語に

```bash
LANG=C xdg-user-dirs-gtk-update
```

## Linuxbrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
```

```bash
curl -fsSL https://raw.githubusercontent.com/yuto51942/my-pc-utils/main/ubuntu/install.sh | bash --linuxbrew
```

## Linuxbrew tools

```bash
brew install git
brew install lsd
brew install vim
```

## zsh

```bash
sudo apt update
sudo apt upgrade
sudo apt install zsh

chsh -s $(which zsh)
```

### prezto

- [prezto repository](https://github.com/sorin-ionescu/prezto)

```bash
# required git
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```

```text
zstyle ':prezto:load' pmodule \
  'environment' \
  'terminal' \
  'editor' \
  'history' \
  'directory' \
  'spectrum' \
  'utility' \
  'completion' \
  'history-substring-search' \
  'prompt' \
  'git' \
  'syntax-highlighting' \
  'autosuggestions' \
  'command-not-found'
```

## Vim

- [何も考えず~/.vimrcにこれを書くんだ！ 〜vim初心者によるvim初心者のためのvim入門〜](https://qiita.com/morikooooo/items/9fd41bcd8d1ce9170301)

```vim
" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd


" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable


" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
```

```bash
# rootユーザでもvim使用
sudo ln -s ~/.vimrc /root/.vimrc
```

## Docker

- [Ubuntu 20.04へのDockerのインストールおよび使用方法](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-ja)
- [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

```bash
# uninstall the old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# view docker versions
apt-cache madison docker-ce

sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io

# run test
sudo docker run hello-world
```

- [Dockerコマンドをsudoなしで実行する方法](https://qiita.com/DQNEO/items/da5df074c48b012152ee)

```bash
# if docker groupe dose not exist.
sudo groupadd docker

sudo gpasswd -a $USER docker
sudo systemctl restart docker
```

## TODO

- sshの公開鍵認証化
- gitのGitHubログイン
  - commitの署名

### sshの公開鍵認証化

- [SSH公開鍵認証で接続するまで](https://qiita.com/kazokmr/items/754169cfa996b24fcbf5)

### gitのGitHubログイン（commitの認証）

- [Gitを使い始めたら一番最初にやりたい `git config`設定メモ](https://blog.katsubemakito.net/git/git-config-1st)
- [GPGの秘密鍵や公開鍵のバックアップ方法](https://www.rk-k.com/archives/3351)

```bash
pager.branch=cat
gpg.program=gpg
user.signingkey=[]
user.email=[]
user.name=[]
commit.gpgsign=true
color.ui=true
core.editor=vim
core.quotepath=false
credential.helper=cache --timeout=86400
```

- GPG秘密鍵の復元

  ```bash
  gpg --import [gpg private key path]
  gpg --import [gpg public key path]
  ```

## TODO: 必要に応じて

- nvm
- goenv
- pyenv
- cargo
- モニタリングツール

### nvm

- [nvm-sh/nvm - github](https://github.com/nvm-sh/nvm)

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```

- .zshrc

  ```bash
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  ```

### goenv

- [syndbg/goenv - github](https://github.com/syndbg/goenv)

```bash
git clone https://github.com/syndbg/goenv.git ~/.goenv

echo 'export GOENV_ROOT="$HOME/.goenv"' >> ~/.zshrc
echo 'export PATH="$GOENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(goenv init -)"' >> ~/.zshrc
echo 'export PATH="$GOROOT/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="$PATH:$GOPATH/bin"' >> ~/.zshrc
```

### pyenv

```bash
brew install pyenv

pyenv install --list
pyenv install [version]
```

### モニタリングツール

- HDD温度

  ```bash
  sudo hddtemp /dev/sdc
  ```

- sshログインしたip

  ```bash
  grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /var/log/auth.log | grep -E 'Accepted' | cut -d ' ' -f 11 | sort | uniq
  ```

- sshログインを試みたものの数

  ```bash
  grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /var/log/auth.log | cut -d ' ' -f 10 | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort | uniq | wc -l
  ```

- sshログインを試みたip

  ```bash
  grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /var/log/auth.log | cut -d ' ' -f 8 | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort | uniq -c | sort -nr
  ```

- sshログインに使用したユーザ名

  ```bash
  grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,4}' /var/log/auth.log | grep -E 'Invalid user' | cut -d ' ' -f 8 | sort | uniq -c | sort -nr
  ```

## アプリケーション

- vscode
- 1password
- chrome

### Chrome

- [Chromeを起動するとログインキーリングのパスワードを入れる画面が表示される](https://help.media.hiroshima-u.ac.jp/index.php?solution_id=1039)
