# macOS オレオレセットアップ

## Index

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
- [macOS オレオレセットアップ](#macos-オレオレセットアップ)
  - [Index](#index)
  - [iTerm2](#iterm2)
    - [Config](#config)
    - [Color & Text](#color--text)
  - [brew](#brew)
  - [zsh](#zsh)
  - [tools](#tools)
    - [prezto](#prezto)
    - [Vim](#vim)
  - [prezto custom](#prezto-custom)
  - [Font](#font)
  - [zshrc](#zshrc)
  - [Apps](#apps)
  - [Setting git](#setting-git)

## iTerm2

- [iterm2.com](https://iterm2.com/)

### Config

[iTerm2 でフルスクリーンで起動しているアプリにターミナルを重ねる](https://gist.github.com/d-kuro/551d98f9d4a28f61b3e8111adc082074)

- `Preferences > General > Window > Native full screen windows`
  - disable
- `Preferences > Profiles > Window > Settings for New Windows > Style`
  - Fullscreen
- `Preferences > Profiles > Window > Settings for New Windows > Screen`
  - Screen with Cursor
- `Preferences > Profiles > Window > Settings for New Windows > Spaces`
  - All Spaces
- `Preferences > Profiles > Keys > A hotkey opens a dedicated window this profile.`
  - Enable
- `Preferences > Profiles > Keys > Configure Hotkey Window`
  - Floating window
    - Enable

### Color & Text

- [iceberg](iceberg.itermcolors.itermcolors)
- Font weight: bold

## brew

- [homeberw](https://brew.sh/index_ja)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## zsh

```bash
brew install zsh

chsh -s $(which zsh)
```

## tools

```bash
brew install git lsd vim
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

### Vim

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

## prezto custom

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

## Font

```bash
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

Apply to iTerm2

## zshrc

```bash
# setting alias to lsd
alias ls='lsd'
alias restart='exec $SHELL -l'

# ctrl a allow
bindkey -e
```

## Apps

- [VSCode](https://code.visualstudio.com/download)
- [docker](https://www.docker.com/products/docker-desktop)

## Setting git

- [git branch が less や more っぽい pager で表示されるのをやめる](https://qiita.com/furu8ma/items/9cf4680171f06c1f95bc)

```bash
git config --global user.email [your email]
git config --global user.name [your name]

git config --global pager.branch false
```
