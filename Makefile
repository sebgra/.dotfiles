resource:
	cp ~/.dotfiles/.aliases ~/.aliases
	cp ~/.dotfiles/.zshrc ~/.zshrc
	cp ~/.dotfiles/.bashrc ~/.bashrc
	cp ~/.dotfiles/.bash_profile ~/.bash_profile
	cp ~/.dotfiles/.tmux.conf ~/.tmux.conf
	cp ~/.dotfiles/starship/starship.toml ~/.config/starship.toml
	cp -r ~/.dotfiles/airmux/ ~/.config/
	cp -r ~/.dotfiles/lazygit/ ~/.config/
	
	@# BAT Config
	if [ ! -f ~/.config/bat/config ]; then \
		mkdir -p ~/.config/bat/ && touch ~/.config/bat/config; \
	else \
		cp ~/.dotfiles/bat/config ~/.config/bat/config; \
	fi

	@# DCONF
	mkdir -p ~/.config/dconf/
	cp ~/.dotfiles/system/user.conf ~/.config/dconf/user.conf
	dconf load / < ~/.config/dconf/user.conf
	
	@# Ghostty Config
	if [ ! -f ~/.config/ghostty/config ]; then \
		mkdir -p ~/.config/ghostty/ && touch ~/.config/ghostty/config; \
	else \
		cp ~/.dotfiles/ghostty/config ~/.config/ghostty/config; \
	fi

	@# Rofi Config
	if [ ! -f ~/.config/rofi/config.rasi ]; then \
		mkdir -p ~/.config/rofi/ && touch ~/.config/rofi/config.rasi; \
	else \
		cp ~/.dotfiles/rofi/config.rasi ~/.config/rofi/config.rasi; \
		cp ~/.dotfiles/rofi/catppuccin-lavrent-mocha.rasi ~/.config/rofi/; \
	fi

	@# Hyprland Config
	if [ ! -f ~/.config/hypr/hyprland.conf ]; then \
		mkdir -p ~/.config/hypr/ && touch ~/.config/hypr/hyprland.conf; \
	else \
		cp ~/.dotfiles/hyprland/hyprland.conf ~/.config/hypr/; \
	fi

	@# Hyprpanel Config
	if [ ! -f ~/.config/hyprpanel/config.json ]; then \
		mkdir -p ~/.config/hyprpanel/ && touch ~/.config/hyprpanel/config.json ~/.config/hyprpanel/modules.json ~/.config/hyprpanel/modules.scss; \
	else \
		cp ~/.dotfiles/hyprpanel/* ~/.config/hyprpanel/; \
	fi

	@# Nvim Config
	if [ ! -d ~/.config/nvim/lua ]; then \
		mkdir -p ~/.config/nvim/; \
	else \
		cp -r ~/.dotfiles/nvim/* ~/.config/nvim/; \
	fi