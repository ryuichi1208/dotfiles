all: mkdir link

mkdir:
	mkdir -p ~/.config/nvim
	mkdir -p ~/.cache/tmp/
	mkdir -p ~/.zsh
	mkdir -p ~/repo
	mkdir -p ~/work
	mkdir -p ~/tmp

link:
	[ -f ~/.vimrc ] || ln -s $(pwd)/mac/vim/.vimrc ~/.vimrc
	[ -f ~/.bashrc ] || ln -s $(pwd)/mac/bashrc ~/.bashrc


