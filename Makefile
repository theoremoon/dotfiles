PKG=sudo pacman -S --noconfirm
PWD=`pwd`

all: i3 nvim zsh yaourt chrome privates japanese

base:
	$(PKG) curl git

yaourt:
	sudo echo -e '[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/$$arch' >> /etc/pacman.conf
	sudo pacman -Syy --noconfirm
	sudo pacman -S yaourt

chrome:
	yaourt -S --noconfirm google-chrome

japanese:
	$(PKG) fcitx-mozc fcitx-configtool fcitx-im
	install -D $(PWD)/.config/fcitx/config $(HOME)/.config/fcitx/config
	install -D $(PWD)/.config/fcitx/profile $(HOME)/.config/fcitx/profile
	echo 'export DefaultImModule=fcitx\nexport GTK_IM_MODULE=fcitx\nexport QT_IM_MODULE=fcitx\nexport XMODIFIERS="@im=fcitx"' > $(HOME)/.profile

i3:
	$(PKG) i3-wm i3-status network-manager-applet pulseaudio rofi
	install -D $(PWD)/.config/i3/config $(HOME)/.config/i3/config
	install -D $(PWD)/.config/i3status/config $(HOME)/.config/i3status/config

nvim: base
	$(PKG) neovim python-neovim python2-neovim
	install -D $(PWD)/.config/nvim/init.vim $(HOME)/.config/nvim/init.vim
	curl -fLo "$(HOME)/.local/share/nvim/site/autoload/plug.vim" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

zsh:
	$(PKG) zsh
	chsh -s `which zsh`
	install "$(PWD)/.zshrc" "$(HOME)/.zshrc"

privates:
	git clone https://github.com/theoldmoon0602/diary.git $(HOME)/diary
	git clone https://github.com/theoldmoon0602/sada_phrase.git $(HOME)/sada_scraping
