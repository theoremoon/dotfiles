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

function displayoptimize() {
  primary=$(xrandr| grep "primary" | awk '{print $1}')
  connected=$(xrandr  | grep " connected" | grep -v "primary" | awk '{print $1}')
  nol=$(echo "${connected}" | sed '/^\s*$/d' | wc -l)

  if [[ "$nol" = 0 ]]; then
    xrandr --auto

  elif [[ "$nol" = 1 ]]; then
    xrandr --output "$connected" --auto --above "$primary"

  else
    echo -e "\e[41m;INVALID NUMBER OF DISPLAYS"
    xrandr --auto

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
alias pentab='xsetwacom --set "Wacom One by Wacom M Pen stylus" mode relative'
alias pentabr='xsetwacom --set "Wacom One by Wacom M Pen stylus" Rotate half'
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

function __c_g() {
  zle -U $(ghq list --full-path | fzf)
}
zle -N __c_g
bindkey "^[g" __c_g

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
alias goinit='go mod init $(pwd | grep -Po "\w+\.\w+\/.+\z")'

function set_windowtitle () {
  echo -ne "\033]0;${1}\007"
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec set_windowtitle

flagpath="$HOME/.local/bin/flag"
if [ ! -f "$flagpath" ]; then
  mkdir "$HOME/.local/bin"
  cat <<'EOF' > "$flagpath"
#!/bin/bash
X="leasto"
Y="134570"
sed -e "y/${X}/${Y}/"
EOF
  chmod +x "$flagpath"
fi

function mkproj() {
  mkdir "$1"
  cd "$1"
  tmux new -s "$1" -d
  if [[ -n $TMUX ]]; then
    tmux switch-client -t "$1"
  else
    tmux attach-session -t "$1"
  fi
}

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
