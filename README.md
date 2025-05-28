# Arch Linux Semi-Automated Installation Guide

This guide outlines a semi-automated process for installing Arch Linux alongside an existing Windows installation, enabling a dual-boot setup.

Scripts mentionned below for all the steps carn be found [here](https://github.com/sebgra/.dotfiles/tree/main/os_install)

---

## Prerequisites

Before you begin, ensure you have:

* A **USB drive** with the Arch Linux installation medium.
* **Windows already installed** on your system.
* **Free space** on your hard drive (shrink your Windows partition if necessary) for the Arch Linux installation.

---

## Installation Steps

### 0. Boot from USB Drive

Plug in your Arch Linux USB installation medium and boot your computer from it.

### 1. Initial Setup from USB

Once booted into the Arch Linux environment from your USB drive, open a terminal.

**Load French Keyboard Layout (Optional, if needed):**
```bash
loadkeys fr
```

**Update System (Optional, but recommended):**

```bash
pacman -Syy
```

**Execute the pre-installation script:**

```bash
bash /scripts/pre_arch_install_step_0.sh
```

This script is assumed to install `archinstall` and its dependencies. If it fails or you prefer to do it manually, you can run:

```bash
pacman -Sy archinstall archlinux-keyring python python-pip python-pyparted python-simple-term-menu python-annotated-types python-pydantic python-pydantic-core python-typing_extensions python-cryptography python-cffi
```

### 2. Prepare Partitions (manual)

You'll need to manually partition your SSD using fdisk.

```bash
fdisk /dev/mve0n1 # IMPORTANT: Replace '/dev/mve0n1' with your SSD's device name if different (e.g., /dev/sda)
```

Then carefully follow the steps below:

Partitioning within fdisk:

- Create 1GB /boot partition:
    - Type `n` and press `Enter`.
    - Press `Enter` for "Partition number" (default is fine).
    - Press `Enter` for "First sector" (default is fine).
    - For "Last sector" enter `+1G` and press Enter.

- Create 80GB / (root) partition:
    - Type `n` and press `Enter`.
    - Press `Enter` for "Partition number".
    - Press `Enter` for "First sector".
    - For "Last sector" enter `+80G` and press Enter.

- Create /home partition (remaining space):
    - Type `n` and press Enter.
    - Press `Enter` for "Partition number".
    - Press `Enter` for "First sector".
    - For "Last sector" simply press `Enter` to **use all remaining free space**.

Write changes and exit fdisk:

- Type `w` and press Enter.

### 3. Run `archinstall`

Now, launch the archinstall script:

```bash
archinstall
```

- Language and Timezone: Set these correctly.
- Desktop Configuration: Choose GNOME.
- Network Utilities: Select the last option in the appropriate menu (usually systemd-networkd).
- Manual Partitioning:

    - Navigate to the manual partitioning section.
        - For the 1GB partition:

        * Assign mountpoint: `/boot`
        * Mark it to be *formatted*.
        * Change the filesystem type to `FAT32`.

        - For the 80GB partition:

        * Assign mountpoint: `/`
        * Mark it to be *formatted*.
        * Change the filesystem type to `ext4`.

    For the last partition (remaining space):
        Assign mountpoint: `/home`
        Mark it to be *formatted*.
        Change the filesystem type to `ext4`.

- Sudo User: Create a sudo user with a strong password.

### 4. Post-Installation (Chroot)

After `archinstall` completes, you will be prompted to select a chrooting procedure. Answer `yes` to chroot.

Once in the chroot environment, execute the following script from your USB medium:

```bash
/scripts/post_arch_install_step_0.sh
```

This script is assumed to handle the initial GRUB setup. For reference, it likely contains:

```bash
grub-install --target=x86_64-efi --efi-directory=/boot --recheck
```

Verify boot options:

```bash
efibootmgr
```

Exit chroot and reboot:

```bash
exit
reboot
```

### 5. Configure Dual Boot (Post-Reboot)

After rebooting into your newly installed Arch Linux, open a terminal and execute the following script:

```bash
post_arch_install_step_1.sh
```

This script will set up GRUB to detect your Windows partition and enable proper dual-boot functionality. For reference, it likely contains:

Install `os-prober`:

```bash
sudo pacman -Sy os-prober
```

- Enable `os-prober` in GRUB configuration:

Open the GRUB default configuration file: 

```bash
sudo vim /etc/default/grub
```

Find the line `GRUB_DISABLE_OS_PROBER=true` and uncomment it (remove the # at the beginning) and change true to false. It should look like this: 


Save the file (Esc + wq).

Execute `os-prober` to detect Windows:

```bash
sudo os-prober
```

Create (re-generate) GRUB configuration:

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Reboot to test dual-boot:

```bash
reboot
```

You should now have a fully functional Arch Linux installation with dual-boot capabilities alongside Windows!