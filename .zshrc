# automatically install zinit
[ ! -f ~/.zinit/bin/zinit.zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
source ~/.zinit/bin/zinit.zsh

# install tools
case ${OSTYPE} in
  darwin*)
    zinit ice from"gh-r" as"program" bpick"*darwin*amd64*"
    zinit light "junegunn/fzf"

    zinit ice from"gh-r" as"program" bpick"*x86_64-apple-darwin*" pick"**/rg"
    zinit light "BurntSushi/ripgrep"

    zinit ice from"gh-r" as"program" bpick"*x86_64*apple-darwin*" pick"**/bat"
    zinit light "sharkdp/bat"

    zinit ice from"gh-r" as"program" bpick"*x86_64*apple-darwin*" pick"**/fd"
    zinit light "sharkdp/fd"

    zinit ice from"gh-r" as"program" bpick"*darwin_amd64*" pick"**/ghq"
    zinit light "x-motemen/ghq"

    zinit ice from"gh-r" as"program" bpick"*macOS_amd64.tar.gz" pick"**/gh"
    zinit light "cli/cli"
    ;;
  linux*)
    zinit ice from"gh-r" as"program" bpick"*linux*amd64*"
    zinit light "junegunn/fzf"

    zinit ice from"gh-r" as"program" bpick"*x86_64*linux-musl*" pick"**/rg"
    zinit light "BurntSushi/ripgrep"

    zinit ice from"gh-r" as"program" bpick"*x86_64*linux-gnu*" pick"**/bat"
    zinit light "sharkdp/bat"

    zinit ice from"gh-r" as"program" bpick"*x86_64*linux-gnu*" pick"**/fd"
    zinit light "sharkdp/fd"

    zinit ice from"gh-r" as"program" bpick"*linux*amd64*" pick"**/ghq"
    zinit light "x-motemen/ghq"

    zinit ice from"gh-r" as"program" bpick"*linux*amd64.tar.gz" pick"**/gh"
    zinit light "cli/cli"
    ;;
esac

zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure

zinit light "zsh-users/zsh-syntax-highlighting"
# hint: zplug update to update tools

# check dotfiles update
if [[ `cd ~/dotfiles && git status --porcelain` ]]; then
  echo -e "\e[41m ~/dotfiles is updated"
fi

# optionals
[ -d ~/.zsh ] && ls ~/.zsh/*.zsh | while read f; do source "$f"; done;


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
if builtin command -v setxkbmap > /dev/null; then
  setxkbmap -layout jp
  setxkbmap -option ctrl:nocaps 2>/dev/null
fi

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


