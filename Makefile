
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
	if [ ! -f ~/.config/bat/config ]; then \
		mkdir -p ~/.config/bat/; \
		touch ~/.config/bat/config; \
	else \
		cp ~/.dotfiles/bat/config ~/.config/bat/config; \
	fi

	cp ~/.dotfiles/system/user.conf ~/.config/dconf/user.conf
	dconf load / < ~/.config/dconf/user.conf
	if [ ! -f ~/.dotfiles/ghostty/config  ]; then \
		mkdir -p ~/.dotfiles/ghostty/ ; \
		touch ~/.config/ghostty/config; \
	else \
		cp ~/.dotfiles/ghostty/config ~/.config/bat/config; \
	fi

pull:
	git pull
 
antigen:
	git clone https://github.com/zsh-users/antigen.git
 
install: 
	antigen source

python_setup:
	cp -r ~/.dotfiles/mamba_envs ~/
	mamba env create -f ~/mamba_envs/hic_analyses.yml
	mamba env create -f ~/mamba_envs/hicberg.yml
	# mamba env create -f ~/mamba_envs/histones.yml
	mamba env create -f ~/mamba_envs/tf2.yml

setup:
	bash terminal_upgrade.sh