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
zstyle :compinstall filename '/home/theoldmoon0602/.zshrc'

autoload -Uz compinit
compinit
autoload -Uz colors
colors
# End of lines added by compinstall

alias v=nvim
alias vim=nvim
alias ls='ls --color=auto'
alias fsnew='dotnet new console -lang="F#" -o'
alias fsrun='dotnet run'
setxkbmap -layout jp
setxkbmap -option ctrl:nocaps 2>/dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export GOPATH=$HOME/go
export PATH=$PATH:$HOME/.local/bin:$HOME/bin/:$HOME/.config/composer/vendor/bin/:$GOPATH/bin:$HOME/.dub/packages/.bin/dls-latest
export PROMPT="[%?]%{$fg[green]%}%3~ %{$reset_color%}% "
eval $(opam env 2>/dev/null)
python ~/sada_phrase/sada.py 2>/dev/null

# check dotfiles update
if [[ `cd ~/dotfiles && git status --porcelain` ]]; then
  echo -e "\e[41m ~/dotfiles is updated"
fi

# zplug
if [ ! -e ~/.zplug/init.zsh ]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug load

function neovimupdate() {
  git fetch
  for commit in $(git log --oneline HEAD..origin/master | awk '{print $1}'| tac); do
    git show $commit
  done
  git merge master origin/master
  make
  sudo make install
}

function displayoptimize() {
  if xrandr | grep -q "HDMI-1 connected"; then
    xrandr --output eDP-1 --primary --mode 1366x768 --pos 157x1050 --rotate normal --output DP-1 --off --output HDMI-1 --mode 1680x1050 --pos 0x0 --rotate normal --output DP-2 --off --output HDMI-2 --off
  elif xrandr | grep -q "DP-1 connected"; then
  xrandr --output eDP-1 --primary --mode 1366x768 --pos 277x1080 --rotate normal --output DP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off
  fi
}

alias writeup='export PS1="$ "'

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export GO111MODULE=on
export PATH="$PATH:/usr/local/dotnet/"
