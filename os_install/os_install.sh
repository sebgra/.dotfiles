## Semi-Automated Installation

# 0. Plug USB-drive and boot on it 

# 1. Execute the script /scripts/pre_arch_install_step_0.sh (script in the usb medium)
#       It will install all the dependencies for archinstall

# 2. Run archinstall and complete installation

# 3. After installation select chrooting procedure
#       Then execute /scripts/post_arch_install_step_0.sh (script in the usb medium)
#       It will set all the necessary for grub

# 4. After reboot, execute  post_arch_install_step_1.sh (on computer)
#       It will set-up the config for grub to detect Windows partition and make the proper dual-boot


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

# Then install arch through archinstall

# Create appropriate partions
#
fdisk /dev/mve0n1; # SSD

# Then type n to create partitions, three to be created:
#
# ## n then enter then "Last sector" :  +1G
# ## n then enter then "Last sector" : +80G
# ## n then enter then "Last sector" --> enter (this will get the remaining free space
#
# Validate the partition creation by writting the new partition table by entering "w"
#


# Launch Archinstall
#
# /!\ Set all the stuff. Do not forget to choose right languages, timezone, Desktop configuration with gnome, Network utilities with the last option in the appropriate menu
#
# /!\ For the partition formating go to manual partitioning -> then do the following
#
# /!\ Do not forget to create a sudo user with appropriate password
#
# ## 1G partition: Assign mountpoint: /boot, mark it to be formatted, change filesystem type to FAT32
# ## 20G partition: Assign mountpoint: / , mark it to be formatted, change filesystem type to ext4
# ## Last partition: Assign mountpoint: /home , mark it to be formatted, change filesystem type to ext4

# Chroot post-install wiht archinstall

## Answer yes to chroot

grub-install --target=x86_64-efi --efi-directory=/boot --recheck;

# Check addition of boot option

efibootmgr;

# Exit and reboot

exit; 
reboot; 

# Install os-prober
#
sudo pacman -Sy os-prober;

## Here uncomment the last line of "/etc/default/grub"

# Execute os-prober

sudo os-prober;

# Create grub config
grub-mkconfig -o /boot/grub/grub.cfg;

reboot;

# Et voila!
#
