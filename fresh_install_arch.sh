# Global update
sudo pacman -Syy

#Install yay
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
# Install utilities
sudo pacman -Sy keepassxc
sudo pacman -Sy firefox
sudo pacman -Sy bc
yay -S zen-browser-bin
sudo pacman -Sy git
sudo pacman -Sy code
sudo curl https://sh.rustup.rs -sSf | sh

# Config git account
ssh-keygen -o -t rsa -C "sebastiengradit@hotmail.com" # Copy to git
git config --global user.email sebastiengradit@hotmail.com && git config --global user.name sebgra

# Clone dotfiles
git clone git@github.com:sebgra/.dotfiles.git

# Zsh config
## Install zsh
sudo pacman -Sy zsh

## Change bash for zsh
chsh -s $(which zsh)

#Oh-my-zsh part
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ## reboot to apply
# reboot;

# Install ghostty
sudo pacman -Sy ghostty

# Install bat
sudo pacman -Sy bat
## Customise bat

mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
# Rebuild bat's cache
bat cache --build
# Check if theme is available
bat --list-themes

touch "$(bat --config-file)"

# Add catpuccin to batcat config

# Install antigen
git clone https://github.com/zsh-users/antigen.git
cd antigen && source antigen.zsh
antigen selfupdate
antigen update

# Change theme for zsh
cd ~/.dotfiles && make && source ~/.zshrc

## Install cargoo first
curl https://sh.rustup.rs -sSf | sh

# Install zoxide (cd)
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Install starship
## Install
curl -sS https://starship.rs/install.sh | sh

## Get nerd font and install
mkdir ~/.local/share/fonts
cd ~/.local/share/fonts/

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip
unzip CascadiaCode.zip

## Source fonts
fc-cache -f -v

# Install eza
cargo install eza

#Install fzf
sudo pacman -S fzf

# Install fd
# apt install fd-find;

# Install tmux
# Clone and install tmux
sudo pacman -Sy tmux

## Install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

# # Install bat
# sudo pacman -Sy bat;
# ## Customise bat

# mkdir -p "$(bat --config-dir)/themes"
# wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
# # Rebuild bat's cache
# bat cache --build
# # Check if theme is available
# bat --list-themes

# touch "$(bat --config-file)"

# # Add catpuccin to batcat config
# echo '--theme="Catppuccin Frappe"' >> "$(bat --config-file)"

#Install Tabiew
## usage on csv tw <path_to_tsv(s)> --separator $'\;' --theme monokai
cargo install tabiew

# Install otree
cargo install --git https://github.com/fioncat/otree

# Install serpl
## Install ripgrep dependency
sudo pacman -Sy ripgrep
cargo install serpl

# Install airmux
cargo install airmux

# Install lazygit

sudo pacman -Sy lazygit

# Install mambaforge
## Make sure not replacing init which is already in .zshrc
~
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh

# Nvim setup
sudo pacman -Sy neovim

### Lazygit
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim

### Luarocks

sudo pacman -S luarocks
luarocks --version

# Install fd-find
cargo install fd-find

# Install ghostty
sudo pacman -Sy ghostty

# Nvidia drivers
## check harware
lspci | grep -E "VGA|3D"

# System update
sudo pacman -Syu --noconfirm

# Required packages
sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings opencl-nvidia xorg-server-devel

# Build config
sudo mkinitcpio -P
sudo nvidia-xconfig

reboot

# Cuda and CuDnn 

yay cuda; # sudo pacman -S cuda
sudo pacman -S linux-headers;
yay nvidia-dkms;
yay nvidia-utils;
yay nvidia-dkms nvidia-utils;
yay nvidia-dkms;
yay nvidia-utils;

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64;

## Check cuda installation
nvcc --version;

## Install Tensorflow with gpu compatibility
pip install 'tensorflow[and-cuda]';

