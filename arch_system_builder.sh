#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration Variables ---
GIT_EMAIL="sebastiengradit@hotmail.com"
GIT_USERNAME="sebgra"
DOTFILES_REPO="git@github.com:sebgra/.dotfiles.git"
OH_MY_ZSH_INSTALL_SCRIPT="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
RUSTUP_INSTALL_SCRIPT="https://sh.rustup.rs"
ZOXIDE_INSTALL_SCRIPT="https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh"
STARSHIP_INSTALL_SCRIPT="https://starship.rs/install.sh"
NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip"
MINIFORGE_URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
BAT_THEME_URL="https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme"
# # Path to Antigen
# ANTIGEN_DIR="$HOME/antigen"

# --- Helper Functions ---

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to install yay if not already installed
install_yay() {
  if ! command_exists yay; then
    echo "Installing yay (AUR helper)..."
    sudo pacman -S --noconfirm --needed git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay_install
    (cd /tmp/yay_install && makepkg -si --noconfirm)
    rm -rf /tmp/yay_install
  else
    echo "yay is already installed."
  fi
}

# Function to install packages using pacman
install_pacman_packages() {
  local packages=("$@")
  echo "Installing pacman packages: ${packages[*]}..."
  sudo pacman -S --noconfirm "${packages[@]}"
}

# Function to install packages using yay
install_yay_packages() {
  local packages=("$@")
  echo "Installing yay packages: ${packages[*]}..."
  yay -S --noconfirm "${packages[@]}"
}

# Function to install Rust via rustup
install_rust() {
  if ! command_exists rustc; then
    echo "Installing Rust via rustup..."
    curl "${RUSTUP_INSTALL_SCRIPT}" -sSf | sh -s -- -y
    # Add cargo to PATH for current session
    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH=$HOME/.cargo/bin:$PATH
  else
    echo "Rust is already installed."
  fi
}

# --- Main Setup Steps ---

echo "Starting Arch Linux system setup..."

# 1. System Update
echo "Performing a global system update..."
sudo pacman -Syu --noconfirm

# 2. Install yay (AUR helper)
install_yay

# 3. Install Core Utilities
echo "Installing core utilities..."
install_pacman_packages \
  git \
  zsh \
  bc \
  neovim \
  tmux \
  fzf \
  ripgrep \
  lazygit \
  keepassxc \
  firefox \
  python-pip \
  ghostty \
  kitty \
  bat \
  luarocks \
  xorg-server-devel # For NVIDIA drivers

install_yay_packages \
  zen-browser-bin \
  visual-studio-code-bin \
  python-pywal16 \
  spotify-player-full \
  dysk \
  navi \
  ranger \
  eza \
  otree \
  fd \


# 4. Git Configuration


echo "Configuring Git account..."

if [ ! -e "$HOME/.ssh/id_rsa.pub" ]; then
  echo "No SSH public key found, creating a new key...";
  # Ensure the .ssh directory exists with correct permissions
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"

  ssh-keygen -t rsa -C "${GIT_EMAIL}" -f "$HOME/.ssh/id_rsa" -N ""; # -N "" for no passphrase
  echo "Please copy the SSH public key ($HOME/.ssh/id_rsa.pub) to your Git hosting service (e.g., GitHub).";
  echo "Key to copy:";
  cat "$HOME/.ssh/id_rsa.pub";
  read -p "Press Enter after copying your SSH key...";

  git config --global user.email "${GIT_EMAIL}";
  git config --global user.name "${GIT_USERNAME}";
else
  echo "SSH key (~/.ssh/id_rsa.pub) already exists. Checking Git configuration...";
  # Optionally, you can add a check here to see if git config is already set
  CURRENT_EMAIL=$(git config --global user.email)
  CURRENT_NAME=$(git config --global user.name)

  if [ "${CURRENT_EMAIL}" != "${GIT_EMAIL}" ] || [ "${CURRENT_NAME}" != "${GIT_USERNAME}" ]; then
    echo "Git global user.email or user.name does not match provided values. Updating...";
    git config --global user.email "${GIT_EMAIL}";
    git config --global user.name "${GIT_USERNAME}";
  else
    echo "Git global user.email and user.name are already configured correctly.";
  fi
fi


# Install Antigen if it's not already there
if [ ! -d "$HOME/antigen" ]; then
  echo "Installing Antigen..."
  cd
  git clone https://github.com/zsh-users/antigen.git 
  echo "Antigen installed."
fi

# # Source Antigen - this must be run every time .zshrc is loaded
# if [ -f "$HOME/antigen/antigen.zsh" ]; then
#   source "$HOME/antigen/antigen.zsh"
# else
#   echo "Error: antigen.zsh not found at $HOME/antigen/antigen.zsh. Please check your Antigen installation."
# fi


# 5. Zsh Configuration
echo "Configuring Zsh..."
if [ "$(basename "$SHELL")" != "zsh" ]; then
  echo "Changing default shell to Zsh..."
  chsh -s "$(which zsh)"
else
  echo "Zsh is already the default shell."
fi

# Install Oh-My-Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh-My-Zsh..."
  sh -c "$(curl -fsSL "${OH_MY_ZSH_INSTALL_SCRIPT}")" "" --unattended
else
  echo "Oh-My-Zsh is already installed."
fi

echo "Cloning dotfiles from ${DOTFILES_REPO}..."
if [ ! -d "$HOME/.dotfiles" ]; then
  git clone "${DOTFILES_REPO}" "$HOME/.dotfiles"
else
  echo "Dotfiles directory already exists. Skipping clone."
fi

echo "Applying dotfiles Zsh configuration..."
# Make sure to handle the 'make' command if it's part of the dotfiles setup
# For simplicity, assuming `make` in .dotfiles sets up the zshrc.
if [ -f "$HOME/.dotfiles/Makefile" ]; then
  (cd "$HOME/.dotfiles" && make)
else
  echo "No Makefile found in .dotfiles. Ensure your .zshrc is correctly linked/sourced."
fi

# Source .zshrc to apply changes immediately for subsequent commands
# source "$HOME/.zshrc"

# 6. Rust Toolchain and Cargo Packages
install_rust

echo "Installing Rust-based utilities via cargo..."

# Install zoxide
if ! command_exists zoxide; then
  echo "Installing zoxide..."
  curl -sSfL "${ZOXIDE_INSTALL_SCRIPT}" | sh
else
  echo "zoxide is already installed."
fi

# Install starship
if ! command_exists starship; then
  echo "Installing starship..."
  curl -sS "${STARSHIP_INSTALL_SCRIPT}" | sh -s -- -y
else
  echo "starship is already installed."
fi

# Install CascadiaCode Nerd Font
echo "Installing CascadiaCode Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "${FONT_DIR}"
if [ ! -f "${FONT_DIR}/CascadiaCode.zip" ]; then
  wget -P "${FONT_DIR}" "${NERD_FONT_URL}"
  unzip -o "${FONT_DIR}/CascadiaCode.zip" -d "${FONT_DIR}"
  rm "${FONT_DIR}/CascadiaCode.zip"
  fc-cache -f -v
else
  echo "Nerd Font already downloaded. Skipping."
fi

# cargo install tabiew
cargo install airmux

# 7. Bat Customization
echo "Customizing bat..."
BAT_CONFIG_DIR="$(bat --config-dir)"
BAT_THEMES_DIR="${BAT_CONFIG_DIR}/themes"
BAT_CONFIG_FILE="$(bat --config-file)"

mkdir -p "${BAT_THEMES_DIR}"
if [ ! -f "${BAT_THEMES_DIR}/Catppuccin Frappe.tmTheme" ]; then
  echo "Downloading Catppuccin Frappe theme for bat..."
  wget -P "${BAT_THEMES_DIR}" "${BAT_THEME_URL}"
  bat cache --build
else
  echo "Catppuccin Frappe theme for bat already exists."
fi

if ! grep -q '--theme="Catppuccin Frappe"' "${BAT_CONFIG_FILE}" 2>/dev/null; then
  echo "Adding Catppuccin Frappe theme to bat config..."
  echo '--theme="Catppuccin Frappe"' >>"${BAT_CONFIG_FILE}"
else
  echo "Catppuccin Frappe theme already configured for bat."
fi

# 8. Tmux Configuration
echo "Configuring Tmux..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing tmux plugin manager (tpm)..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  echo "tpm is already cloned."
fi
# Source .tmux.conf if it exists (assuming it's managed by dotfiles)
if [ -f "$HOME/.tmux.conf" ]; then
  tmux source "$HOME/.tmux.conf"
else
  echo "Warning: .tmux.conf not found. Ensure it's correctly linked/created."
fi

# 9. Mambaforge Installation
echo "Installing Mambaforge..."
MINIFORGE_INSTALLER="/tmp/Miniforge3-$(uname)-$(uname -m).sh"
if [ ! -f "$HOME/mambaforge/bin/conda" ] && [ ! -f "$HOME/miniforge3/bin/conda" ]; then # Check for both default install paths
  wget -O "${MINIFORGE_INSTALLER}" "${MINIFORGE_URL}"
  # Use -b for batch mode, -p for prefix, -s for silent
  bash "${MINIFORGE_INSTALLER}" -b -p "$HOME/miniforge3"
  rm "${MINIFORGE_INSTALLER}"
  ~/miniforge3/bin/conda init zsh
  mamba init
  echo "Mambaforge installed to $HOME/miniforge3. Please initialize it in your shell if not already done."
  echo "Example: ~/miniforge3/bin/conda init zsh"
else
  echo "Mambaforge appears to be already installed."
fi

# 10. Neovim Lazygit Setup
echo "Setting up Neovim with LazyVim starter..."
# Backup existing nvim config if it exists
if [ -d "$HOME/.config/nvim" ]; then
  echo "Backing up existing Neovim config..."
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
fi
if [ -d "$HOME/.local/share/nvim" ]; then
  mv "$HOME/.local/share/nvim" "$HOME/.local/share/nvim.bak"
fi
if [ -d "$HOME/.local/state/nvim" ]; then
  mv "$HOME/.local/state/nvim" "$HOME/.local/state/nvim.bak"
fi
if [ -d "$HOME/.cache/nvim" ]; then
  mv "$HOME/.cache/nvim" "$HOME/.cache/nvim.bak"
fi

if [ ! -d "$HOME/.config/nvim" ]; then
  echo "Cloning LazyVim starter..."
  git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
  rm -rf "$HOME/.config/nvim/.git"
  echo "LazyVim starter cloned. You may need to open nvim to complete the setup."
else
  echo "Neovim config directory already exists. Skipping LazyVim clone."
fi

# 11. NVIDIA Drivers and CUDA (Arch-specific)
echo "--- NVIDIA Drivers and CUDA Setup (Arch-specific) ---"

echo "Checking for NVIDIA hardware..."
if lspci | grep -E "VGA|3D" | grep -i nvidia; then
  echo "NVIDIA GPU detected. Proceeding with driver installation."

  echo "Ensuring linux-headers are installed..."
  sudo pacman -S --noconfirm linux-headers

  echo "Installing NVIDIA drivers and utilities..."
  # The original script had several `yay` commands for nvidia-dkms/utils.
  # Consolidating them and using pacman for official packages.
  install_pacman_packages \
    nvidia \
    nvidia-utils \
    nvidia-settings \
    opencl-nvidia \
    #nvidia-dkms

  # Use yay for dkms version if specific version is preferred or needed
  install_yay_packages \
    cuda \
    cudnn
    # nvidia-dkms \

  echo "Building kernel modules with mkinitcpio..."
  sudo mkinitcpio -P

  echo "Generating xorg.conf for NVIDIA..."
  # This command can sometimes cause issues. Use with caution or consider display manager setup.
  sudo nvidia-xconfig || echo "nvidia-xconfig failed. This might be normal if using a modern display server setup (e.g., Wayland)."

  echo "You might need to reboot your system for NVIDIA drivers to take full effect."
  echo "To test CUDA: nvcc --version"

  # Add CUPTI to LD_LIBRARY_PATH (consider adding to .zshrc for persistence)
  # This should ideally be added to your shell's rc file (.zshrc) for persistence
  if ! grep -q 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64' "$HOME/.zshrc" 2>/dev/null; then
    echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64' >>"$HOME/.zshrc"
    echo "Added CUPTI path to .zshrc. Please source it or restart your shell."
  fi
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64 # For current session

  echo "Installing TensorFlow with GPU compatibility..."
  yay -Sy python-pip install 'tensorflow[and-cuda]' --noconfirm
else
  echo "No NVIDIA GPU detected. Skipping NVIDIA driver and CUDA installation."
fi

# 12. Hyprland installation with add-ons and configuration

## Initial setup

echo "Installing Hyprland and primary add-ons"

install_yay_packages \
    hyprland \
    rofi \
    wofi \

## Hyprpanel + dependencies installation

echo "Installing Hyprpanel and dependencies"

yay -S --needed aylurs-gtk-shell-git wireplumber libgtop bluez bluez-utils btop networkmanager dart-sass wl-clipboard brightnessctl swww python upower pacman-contrib power-profiles-daemon gvfs gtksourceview3 libsoup3 grimblast-git wf-recorder-git hyprpicker matugen-bin python-gpustat hyprsunset-git
yay -S ags-hyprpanel-git --noconfirm


echo "--- Setup Complete ---"
echo "A reboot might be necessary for all changes to take full effect, especially after shell or display driver changes."
echo "You can type 'reboot' to restart your system now if needed."

