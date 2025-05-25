############################################################################################################
############################################################################################################
### This is intented to be executed just after arch being installed through archinstall and after reboot ###
############################################################################################################
############################################################################################################

#!/bin/bash


#Install os-prober
echo "--- Installing os-prober ---"
pacman -Sy os-prober --noconfirm

# Uncomment the last line of "/etc/default/grub" for os-prober
# This assumes the line is commented out and needs to be uncommented.
# A safer way might be to add GRUB_DISABLE_OS_PROBER=false if it's not there.
echo "--- Enabling os-prober in /etc/default/grub ---"
sed -i '/^#GRUB_DISABLE_OS_PROBER=false/s/^#//' /etc/default/grub
# Fallback/alternative: If the line doesn't exist or is different, ensure it's set
if ! grep -q "GRUB_DISABLE_OS_PROBER=false" /etc/default/grub; then
    echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
fi


# Execute os-prober (this usually happens automatically with grub-mkconfig when os-prober is enabled)
# For good measure, you can run it.
echo "--- Running os-prober ---"
os-prober

# Create grub config
echo "--- Creating GRUB configuration ---"
grub-mkconfig -o /boot/grub/grub.cfg

echo "--- GRUB configuration complete. Rebooting in 5 seconds... ---"
sleep 5
reboot