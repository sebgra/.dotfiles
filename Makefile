
all: pull resource
 
resource:
	cp ~/.dotfiles/.aliases ~/.aliases
	cp ~/.dotfiles/.zshrc ~/.zshrc
	cp ~/.dotfiles/.bashrc ~/.bashrc
	cp ~/.dotfiles/.bash_profile ~/.bash_profile
	cp ~/.dotfiles/.tmux.conf ~/.tmux.conf
	cp ~/.dotfiles/starship.toml ~/.config/starship.toml
	cp -r ~/.dotfiles/airmux/ ~/.config/
	cp -r ~/.dotfiles/lazygit/ ~/.config/
	cp ~/.dotfiles/bat/config ~/.config/bat/config
	

pull:
	git pull
 
antigen:
	git clone https ://github.com/zsh-users/antigen.git
 
install: 
	antigen source

python_setup:
	cp -r ~/.dotfiles/mamba_envs ~/
	mamba env create  -f ~/mamba_envs/hic_analyses.yml
	mamba env create -f ~/mamba_envs/hicberg.yml
	# mamba env create -f ~/mamba_envs/histones.yml
	mamba env create -f ~/mamba_envs/tf2.yml

setup:
	bash terminal_upgrade.sh