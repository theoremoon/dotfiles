PKG="sudo pacman -S --noconfirm "

all: i3 nvim zsh privates 


base:
	$(PKG) curl git

i3:
	$(PKG) i3-wm i3-status network-manager-applet pulseaudio rofi
	install -D ./config/i3/config $HOME/.config/i3/config
	install -D ./config/i3status/config $HOME/.config/i3status/config

nvim: base
	$(PKG) neovim python-neovim python2-neovim
	install -D ./config/nvim/init.nvim $HOME/.config/nvim/init.vim
	curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

zsh:
	$(PKG) zsh
	chsh -s `which zsh`
	install "./zshrc" "$HOME/.zshrc"

privates:
	git clone https://github.com/theoldmoon0602/diary.git $HOME/diary
	git clone https://github.com/theoldmoon0602/sada_phrase.git $HOME/sada_scraping
