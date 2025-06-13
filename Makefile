all: pull resource
 
resource:
	cp ~/.dotfiles/.aliases ~/.aliases
	cp ~/.dotfiles/.zshrc ~/.zshrc
	cp ~/.dotfiles/.bashrc ~/.bashrc
	cp ~/.dotfiles/.bash_profile ~/.bash_profile
	cp ~/.dotfiles/.tmux.conf ~/.tmux.conf
	cp ~/.dotfiles/starship/starship.toml ~/.config/starship.toml
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
	
	if [ ! -f ~/.config/ghostty/config  ]; then \
		mkdir -p ~/.config/ghostty/ ; \
		touch ~/.config/ghostty/config; \
	else \
		cp ~/.dotfiles/ghostty/config ~/.config/ghostty/config; \
	fi

	if [ ! -f ~/.config/rofi/config.rasi ]; then \
		mkdir -p ~/.config/rofi/; \
		touch ~/.config/rofi/config.rasi; \
	else \
		cp ~/.dotfiles/rofi/config.rasi ~/.config/rofi/config.rasi; \
		cp ~/.dotfiles/rofi/catpuccin-lavrent-mocha.rasi ~/.config/rofi/;\
	fi

	if [ ! -f ~/.config/hypr/hyprland.conf ]; then \
		mkdir -p ~/.config/hypr/; \
		touch ~/.config/hypr/hyprland.conf; \
	else \
		cp  ~/.dotfiles/hypr/hyprland.conf ~/.config/hypr/;\
	fi

	if [ ! -f ~/.config/hyprpanel/config.json ]; then \
		mkdir -p ~/.config/hyprpanel/; \
		touch ~/.config/hyprpanel/config.json; \
		touch ~/.config/hyprpanel/modules.json; \
		touch ~/.config/hyprpanel/modules.scss; \
	else \
		cp  ~/.dotfiles/hyprpanel/* ~/.config/hyprpanel/;\
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
