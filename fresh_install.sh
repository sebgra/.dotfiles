# Install essential (make, etc.)

sudo apt-get install build-essential;
sudo apt install curl;
sudo apt-get install --reinstall pkg-config cmake-data;
sudo apt-get install autotools-dev;
sudo apt-get install automake -y; 
sudo apt install libevent-dev -y;
sudo apt-get install bison -y;
sudo apt-get install byacc -y;
sudo apt install libncurses-dev -y;
sudo sudo apt install python3-pip -y;

# Install keepass
sudo add-apt-repository ppa:phoerious/keepassxc;
sudo apt update;
sudo apt install keepassxc;

# Generate ssh key for github
ssh-keygen -o -t rsa -C "sebastiengradit@hotmail.com";

# Copy ssh key into github account

# Install git
sudo apt install git -y;
git config --global user.email sebastiengradit@hotmail.com && git config --global user.name sebgra;


# Clone dotfiles
git clone git@github.com:sebgra/.dotfiles.git;

# Zsh config

## Install zsh
sudo apt install zsh -y;

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)";

## Change bash for zsh
chsh -s $(which zsh);

## reboot to apply
reboot;

# Install antigen
git clone https://github.com/zsh-users/antigen.git;
cd antigen && source antigen.zsh
antigen selfupdate;
antigen update;


# Change theme for zsh
cd ~/.dotfiles && make && source ~/.zshrc;

# Install zoxide (cd)
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh;

# Install starship
## Install
curl -sS https://starship.rs/install.sh | sh;

## Get nerd font and install
mkdir ~/.local/share/fonts && cd ~/.local/share/fonts/;

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip && unzip CascadiaCode.zip;

## Source fonts
fc-cache -f -v;

# Install eza
sudo apt update;
sudo apt install -y gpg;

sudo mkdir -p /etc/apt/keyrings;
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg;
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list;
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list;
sudo apt update;
sudo apt install -y eza;

#Install fzf
sudo apt install fzf;

# Install fd
apt install fd-find;


# Install tmux
# Clone and install tmux
cd;
wget https://github.com/tmux/tmux/releases/download/3.4/tmux-3.4.tar.gz;
tar -zxf tmux-*.tar.gz;
cd tmux-*/;
./configure;
make && sudo make install;

## Install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm;
tmux source ~/.tmux.conf;

# Install bat
sudo apt install bat;

## Customise bat

mkdir -p "$(batcat --config-dir)/themes"
wget -P "$(batcat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
# Rebuild bat's cache
batcat cache --build
# Check if theme is available
batcat --list-themes

touch "$(batcat --config-file)"

# Add catpuccin to batcat config
echo '--theme="Catppuccin Frappe"' >> "$(batcat --config-file)"

#Install Tabiew 
## usage on csv tw <path_to_tsv(s)> --separator $'\;' --theme monokai
cargo install tabiew;

# Install otree
cargo install --git https://github.com/fioncat/otree;

# Install serpl
## Install ripgrep dependency
sudo apt-get install ripgrep;
cargo install serpl;

#Add catpuccin to KDE
git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde &&  catppuccin-kde;
./install.sh;

# Install airmux

## Install cargoo first
curl https://sh.rustup.rs -sSf | sh;
cargo install airmux;

# Install lazygit

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin


# Install mambaforge
## Make sure not replacing init which is already in .zshrc
cd;
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh


# Nvim setup

## Install nvChad prerequisites
sudo snapp install nvim --classic;

git clone https://github.com/NvChad/starter ~/.config/nvim && nvim;

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash;
nvm install 20;

### Lazygit
# required
mv ~/.config/nvim{,.bak};

# optional but recommended
mv ~/.local/share/nvim{,.bak};
mv ~/.local/state/nvim{,.bak};
mv ~/.cache/nvim{,.bak};

git clone https://github.com/LazyVim/starter ~/.config/nvim;
rm -rf ~/.config/nvim/.git;
nvim;

### Luarocks

sudo apt install luarocks;
luarocks --version;
cargo install fd-find;


