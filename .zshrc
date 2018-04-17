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
PROMPT="%F{$PINK}%~>%f "
RPROMPT="%(?..%F{$RED}[%?]%f)%*"

# golang
GOPATH="$HOME/go"
PATH="$PATH:$GOPATH/bin"

# path
PATH="$PATH:$HOME/bin"

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
alias diary="python3 $HOME/diary/diary.py"

# fun fun function
hoge() { echo 'HOGE' | toilet --gay -f smblock; }

export LANG=en_US.UTF-8
export EDITOR="vim"
export PATH="/home/theoldmoon0602/anaconda3/bin:$PATH"
export PATH=/home/theoldmoon0602/.config/composer/vendor/bin:$PATH

export PATH="$HOME/.cargo/bin:$PATH"

setxkbmap -option ctrl:nocaps


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

diary check
python $HOME/sada_scraping/sada.py
