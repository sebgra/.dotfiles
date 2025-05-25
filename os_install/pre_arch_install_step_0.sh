############################################################################################################
############################################################################################################
### This is intented to be executed prior anything else ####################################################
############################################################################################################
############################################################################################################

#!/bin/bash

# Install windows first, then shrink partition to free space for arch install
#
# then boot on USB stick containing arch
#
## Load fr keyboard layout
loadkeys fr;

# Update system
pacman -Syy;

# Install archinstall and dependencies
pacman -Sy archinstall archlinux-keyring python python-pip python-pyparted python-simple-term-menu python-annotated-types python-pydantic python-pydantic-core python-typing_extensions ;

pacman -S python-cryptography python-cffi;