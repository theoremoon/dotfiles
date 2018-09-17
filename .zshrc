# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt appendhistory #appending instead of overwriting

# vi like key binding
bindkey -e

# auto completion
autoload -Uz compinit
compinit

# push cd history to stack
setopt auto_pushd

# check command name
setopt correct

# disable beep
setopt no_beep

# prompt settings
local PINK=200
local RED=001
PROMPT="%F{$PINK}[${HOST}]%~>%f "
RPROMPT="%(?..%F{$RED}[%?]%f)%*"

# golang
export GOPATH="$HOME/go"
export GO111MODULE=on
export PATH="$PATH:$GOPATH/bin"

# path
export PATH="$PATH:$HOME/bin"

# replace rm with move
gotrash() {
  trashdir="$HOME/trash"
  mkdir -p $trashdir
  for f in $@; do
      mv "$f" "${trashdir}/${f:t}_$(date +%s)"
  done
}
alias rm='gotrash'

# alias
alias vim='nvim'
alias ls='ls --color=auto'

# fun fun function
hoge() { echo 'HOGE' | toilet --gay -f smblock; }

export LANG=en_US.UTF-8
export EDITOR="vim"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.dub/packages/.bin:$PATH"

setxkbmap -option ctrl:nocaps 2>/dev/null


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

python $HOME/sada_scraping/sada.py 2>/dev/null

# OPAM configuration
. /home/theoldmoon0602/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export FZF_DEFAULT_COMMAND='ag -l -g ""'

alias gitp="git push origin master"
alias gits="git status"
function cdg() {
  cd "$(git rev-parse --show-toplevel)/$@"
}

export PATH="$HOME/.cargo/bin:$PATH"

if [ ! -e $HOME/.zplug ]; then
  echo 'Installing zplug...'
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

source $HOME/.zplug/init.zsh

zplug "jhawthorn/fzy", as:command, rename-to:fzy, hook-build:"make && sudo make install"
zplug "b4b4r07/enhancd", use:init.sh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# zplug check returns true if all packages are installed
# Therefore, when it returns false, run zplug install
if ! zplug check; then
    zplug install
fi

# source plugins and add commands to the PATH
zplug load
