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

export EDITOR=nvim
alias vim=nvim
alias ls='ls --color=auto'
alias fsnew='dotnet new console -lang="F#" -o'
alias fsrun='dotnet run'
setxkbmap -layout jp
setxkbmap -option ctrl:nocaps 2>/dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zplug
if [ ! -e ~/.zplug/init.zsh ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug load

function displayoptimize() {
  if xrandr | grep -q "HDMI-1 connected"; then
    xrandr --output eDP-1 --primary --mode 1366x768 --pos 157x1050 --rotate normal --output DP-1 --off --output HDMI-1 --mode 1680x1050 --pos 0x0 --rotate normal --output DP-2 --off --output HDMI-2 --off
  elif xrandr | grep -q "DP-1 connected"; then
  xrandr --output eDP-1 --primary --mode 1366x768 --pos 277x1080 --rotate normal --output DP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off
  fi
}

alias writeup='export PROMPT="$ "'
export PROMPT="[%?]%{$fg[green]%}%3~ %{$reset_color%}%"


# check dotfiles update
if [[ `cd ~/dotfiles && git status --porcelain` ]]; then
  echo -e "\e[41m ~/dotfiles is updated"
fi
python ~/sada_phrase/sada.py 2>/dev/null


export PYENV_ROOT="$HOME/.pyenv"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
eval $(opam env 2>/dev/null)

export GO111MODULE=on
export GOPATH=$HOME/go
export PATH="$PATH:$HOME/.local/bin:$HOME/bin/:$HOME/.config/composer/vendor/bin/:$GOPATH/bin:$HOME/.dub/packages/.bin/dls-latest:$PYENV_ROOT/bin:/usr/local/go/bin:$HOME/.poetry/bin:$HOME/.cargo/bin"

alias FIXCAPS="xdotool key Caps_Lock"
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
alias pyenvinit='eval "$(pyenv init -)"'

function build() {
  cat $(ls | grep "^build") | bash /dev/stdin "$@" <<'DOC'
if type "$1" 2>/dev/null >/dev/null; then
    f="$1"
    shift
    set -x
    "$f" "$@"
fi
DOC
}

alias d='cd $(find . -type d | fzf)'
