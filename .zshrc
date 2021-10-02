# automatically install zplug
[ ! -f ~/.zplug/init.zsh ] && curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
source ~/.zplug/init.zsh

# install tools
case ${OSTYPE} in
  darwin*)
    zplug "junegunn/fzf", from:gh-r, as:command, rename-to:fzf, use:"*darwin*amd64*"
    zplug "BurntSushi/ripgrep", from:gh-r, as:command, rename-to:rg, use:"*x86_64-apple-darwin*"
    zplug "x-motemen/ghq", from:gh-r, as:command, rename-to:ghq, use:"*darwin_amd64*"
    ;;
  linux*)
    zplug "junegunn/fzf", from:gh-r, as:command, rename-to:fzf, use:"*linux*amd64*"
    zplug "BurntSushi/ripgrep", from:gh-r, as:command, rename-to:rg, use:"*x86_64*linux-musl*"
    zplug "x-motemen/ghq", from:gh-r, as:command, rename-to:ghq, use:"*linux_amd64*"
    ;;
esac
zplug mafredri/zsh-async, from:github
zplug 'sindresorhus/pure', use:pure.zsh, from:github, as:theme

zplug "zsh-users/zsh-syntax-highlighting"
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
if ! zplug check --verbose; then
    printf "install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load
# hint: zplug update to update tools

# check dotfiles update
if [[ `cd ~/dotfiles && git status --porcelain` ]]; then
  echo -e "\e[41m ~/dotfiles is updated"
fi


# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt extendedglob notify
setopt nobeep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
autoload -Uz compinit
compinit
autoload -Uz colors
colors
# End of lines added by compinstall
 
# general
export EDITOR=nvim
alias vim=nvim
alias ls='ls --color=auto'
setxkbmap -layout jp
setxkbmap -option ctrl:nocaps 2>/dev/null

alias FIXCAPS="xdotool key Caps_Lock"
alias pentab='xsetwacom --set "Wacom One by Wacom M Pen stylus" mode relative'
alias pentabr='xsetwacom --set "Wacom One by Wacom M Pen stylus" Rotate half'

# ghq fzf integration. fast cd to git project
function g() {
  if [ $# -eq 1 ]; then
    dir=$(ghq list --full-path | grep "/$1\$")
  else
    dir=$(ghq list --full-path | fzf)
  fi

  if [ -n "$dir" ]; then
    cd "$dir"
  fi
}

function _g() {
  _values '' $(ghq list --full-path | xargs -I@ basename @)
}
compdef _g g

# M-g to copy project path to prombt
function __c_g() {
  zle -U $(ghq list --full-path | fzf)
}
zle -N __c_g
bindkey "^[g" __c_g

# go
export GO111MODULE=on
export GOPATH=$HOME/go
export PATH="$PATH:$HOME/.local/bin:$HOME/bin/:$HOME/.config/composer/vendor/bin/:$GOPATH/bin:$HOME/.dub/packages/.bin/dls-latest:$PYENV_ROOT/bin:/usr/local/go/bin:$HOME/.poetry/bin:$HOME/.cargo/bin"
alias goinit='go mod init $(pwd | grep -Po "\w+\.\w+\/.+\z")'


