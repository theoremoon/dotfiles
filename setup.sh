#!/bin/sh

# install
i () {
  pacman -S --noconfirm $@
}

# deploy
d () {
  su $SUDO_USER -c "install $1 $2"
}

: "install importants" && {
  i curl
  i git
}

: "install i3" && {
  i i3-wm
  i i3-status
  d "./config/i3/config" "$HOME/.config/i3/config"
  d "./config/i3status/config" "$HOME/.config/i3status/config"
}

: "install nvim" && {
  i neovim python-neovim python2-neovim
  d "./config/nvim/init.nvim" "$HOME/.config/nvim/init.vim"
  curl -fLo "~/.local/share/nvim/site/autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
}

: "install zsh" && {
  i zsh
  chsh -s `which zsh` $SUDO_USER
  install "./zshrc" "$HOME/.zshrc"
}

: "install utilities" && {
  i xfce4-terminal
  i network-manager-applet
  i pulseaudio
  i rofi
}

: "download private repositories" && {
  git clone https://github.com/theoldmoon0602/diary.git $HOME/diary
  git clone https://github.com/theoldmoon0602/sada_phrase.git $HOME/sada_scraping
}
