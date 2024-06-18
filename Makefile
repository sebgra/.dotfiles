
all: pull resource
 
resource:
	cp ~/.dotfiles/.aliases ~/.aliases
	cp ~/.dotfiles/.zshrc ~/.zshrc
	cp ~/.dotfiles/.bashrc ~/.bashrc
	cp ~/.dotfiles/.bash_profile ~/.bash_profile
	cp ~/.dotfiles/.tmux.conf ~/.tmux.conf
pull:
	git pull
 
antigen:
	git clone https ://github.com/zsh-users/antigen.git
 
install: 
	antigen source

setup:
	bash terminal_upgrade.sh