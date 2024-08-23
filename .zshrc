# automatically install zinit
[ ! -f ~/.local/share/zinit/zinit.git/zinit.zsh ] && sh -c "$(curl -fsSL https://git.io/zinit-install)"
source ~/.local/share/zinit/zinit.git/zinit.zsh

# install tools
case ${OSTYPE} in
darwin*)
    case ${CPUTYPE} in
    x86_64)
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
    arm64)
        zinit ice from"gh-r" as"program" bpick"*darwin*arm64*"
        zinit light "junegunn/fzf"

        zinit ice from"gh-r" as"program" bpick"*aarch64-apple-darwin*" pick"**/rg"
        zinit light "microsoft/ripgrep-prebuilt"

        zinit ice from"gh-r" as"program" bpick"*aarch64-apple-darwin*" pick"**/delta"
        zinit light "dandavison/delta"

        # zinit ice from"gh-r" as"program" bpick"*x86_64*apple-darwin*" pick"**/bat"
        # zinit light "sharkdp/bat"

        # zinit ice from"gh-r" as"program" bpick"*x86_64*apple-darwin*" pick"**/fd"
        # zinit light "sharkdp/fd"

        # zinit ice from"gh-r" as"program" bpick"*darwin_amd64*" pick"**/ghq"
        # zinit light "x-motemen/ghq"

        # zinit ice from"gh-r" as"program" bpick"*macOS_amd64.tar.gz" pick"**/gh"
        # zinit light "cli/cli"
        ;;
    esac
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

zinit ice from"gh-r" as"program" bpick"*linux*amd64.tar.gz" pick"**/txeh"
zinit light "txn2/txeh"

zinit ice from"gh-r" as"program" bpick"*x86_64*linux-gnu*" pick"**/delta"
zinit light "dandavison/delta"
;;
esac

# with zsh-async library that's bundled with it.
zinit ice pick"async.zsh" src"pure.zsh" 
zinit light sindresorhus/pure

zinit light "zsh-users/zsh-syntax-highlighting"
# hint: zplug update to update tools

# completions
zinit ice as"completion" wait"0" lucid atinit"zpcompinit"
zinit snippet https://github.com/theoremoon/go-task-completion/blob/main/_task

# check dotfiles update
if [[ `cd ~/dotfiles && git status --porcelain` ]]; then
  echo -e "\e[40;1m ~/dotfiles is updated"
fi

# RPROMPT
RPROMPT='[%D{%H:%M:%S}]'
function re-prompt() {
  zle .reset-prompt
  zle .accept-line
}
zle -N accept-line re-prompt  # update date on execute command

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
alias writeup='export PS1="$ "';

export FZF_DEFAULT_OPTS="-e"

# fzf history selector
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

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

# M-f to fill the file path to prompt
function __c_f() {
  zle -U $(fd | fzf)
}
zle -N __c_f
bindkey "^[f" __c_f

# M-^ to rise directory up
function __rise_dir() {
  cd ..
  zle reset-prompt
}
zle -N __rise_dir
bindkey "^[u" __rise_dir

function __c_s() {
  branch=$(git branch --format="%(refname:short)" --sort=-committerdate | fzf)
  if [ -n "$branch" ]; then
    git switch "$branch"
  fi
}
zle -N __c_s
bindkey "^[s" __c_s

# go
export GO111MODULE=on
export GOPATH=$HOME/go
export PATH="$PATH:$HOME/.local/bin:$HOME/bin/:$HOME/.config/composer/vendor/bin/:$GOPATH/bin:$HOME/.dub/packages/.bin/dls-latest:$PYENV_ROOT/bin:/usr/local/go/bin:$HOME/.poetry/bin:$HOME/.cargo/bin"
alias goinit='go mod init $(pwd | grep -Po "\w+\.\w+\/.+\z")'

function get_sleep() {
  OFFSET=${1:-0}
  TOKEN="${XDG_CONFIG_HOME:-$HOME/.config}/oura/token"
  start_date=$(date +"%Y-%m-%d" --date "today+$((-1-$OFFSET)) day")
  end_date=$(date +"%Y-%m-%d"  --date "today+$((0-$OFFSET)) day")
  
  curl -sSL "https://api.ouraring.com/v2/usercollection/sleep?start_date=${start_date}&end_date=${end_date}" -H "Authorization: Bearer $(cat $TOKEN)" | jq ".data[0].bedtime_start,.data[-1].bedtime_end"
}

function get_eol() {
  if [[ "$OSTYPE" != "linux-gnu" ]]; then
    return
  fi
  source /etc/os-release
  eol=$(grep -F "$VERSION_ID" /usr/share/distro-info/ubuntu.csv | cut -d, -f 6)
  d=$(( ($(date +%s -d "$eol") - $(date +%s)) / 86400 ))
  if [[ "$d" -lt 30 ]]; then
    echo -e "\e[31;1m EOL of ${VERSION} is coming (${eol})"
  fi
}
get_eol

function sage-docker() {
  if [[ $# -eq 0 ]]; then
    docker run --network=host --platform linux/x86_64 --rm -it -v "$(pwd):/work" -w /work sage bash
  elif [[ "$1" =~ \.py$ ]]; then
    docker run --network=host --platform linux/x86_64 --rm -it -v "$(pwd):/work" -w /work sage python3 $@
  elif [[ "$1" =~ \.sage$ ]]; then
    docker run --network=host --platform linux/x86_64 --rm -it -v "$(pwd):/work" -w /work sage sage $@
  else
    docker run --network=host --platform linux/x86_64 --rm -it -v "$(pwd):/work" -w /work sage $@
  fi
}
