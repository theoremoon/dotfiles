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
# End of lines added by compinstall

alias v=nvim
alias vim=nvim
alias ls='ls --color=auto'
setxkbmap -layout jp
setxkbmap -option ctrl:nocaps 2>/dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$PATH:$HOME/.local/bin:$HOME/bin/:$HOME/.config/composer/vendor/bin/
export GOPATH=$HOME/go

source /home/theoldmoon0602/.local/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh
eval $(opam env)
