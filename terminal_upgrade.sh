# Clone and install tmux
cd;
git clone https://github.com/tmux/tmux.git;
cd tmux;
sh autogen.sh;
./configure && make;

# Add catpuccin to batcat 

mkdir -p "$(batcat --config-dir)/themes"
wget -P "$(batcat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
# Rebuild bat's cache
batcat cache --build
# Check if theme is available
batcat --list-themes

touch "$(batcat --config-file)"

# Add catpuccin to batcat config
echo '--theme="Catppuccin Frappe"' >> "$(batcat --config-file)"

#Add catpuccin to KDE

git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde && cd catppuccin-kde
./install.sh