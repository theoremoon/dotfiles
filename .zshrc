# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
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
export PATH=$PATH:$HOME/.local/bin:$HOME/bin/:$HOME/.config/composer/vendor/bin/:$GOPATH/bin
export PROMPT="[%?]%{$fg[green]%}%3~ %{$reset_color%}% "
eval $(opam env)
python ~/sada_phrase/sada.py

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
  echo 'sudo make install'
}
