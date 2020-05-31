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
  primary=$(xrandr| grep "primary" | awk '{print $1}')
  connected=$(xrandr  | grep " connected" | grep -v "primary" | awk '{print $1}')
  nol=$(echo "${connected}" | wc -l)
  if [[ "$nol" -gt 1 ]]; then
    echo -e "\e[41m;TOO MANY NUMBERS OF DISPLAYS"
  fi

  xrandr --output "$connected" --auto --above "$primary"
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
alias goinit='go mod init $(pwd | grep -Po "\w+\.\w+\/.+\z")'

function set_windowtitle () {
  echo -ne "\033]0;${1}\007"
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec set_windowtitle


function applog() {
  TODAY=$(date "+%Y-%m-%d")
  LOGDIR="${HOME}/applog"
  LOGFILE="${LOGDIR}/${TODAY}"
  LOCKFILE="/tmp/applog${TODAY}.lock"
  INTERVAL=60

  if [[ -f "${LOCKFILE}" ]]
  then
    return
  fi

  echo "START"

  touch "${LOCKFILE}"
  mkdir -p "${LOGDIR}"
  touch "${LOGFILE}"

  while : ;
  do
    echo "TICK"
    sleep "${INTERVAL}"
    WINDOW=$(xdotool getwindowfocus getwindowname)
    PREV=$(tail -n1 "${LOGFILE}" | cut -d' ' -f2-)
    echo "PREV=${PREV}"
    if [[ "${WINDOW}" != "${PREV}" ]];
    then
      NOW=$(date "+%H:%M:%S")
      echo "${NOW} ${WINDOW}" >> "${LOGFILE}"
    fi
  done
}
if [ -d "$HOME/applog" ]; then
  # instead of nohup
  (trap '' HUP INT
  applog) > "${HOME}/applog/nohup.out" &!
fi
