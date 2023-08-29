#!/bin/bash                   
#
# -----------------------------------------------------------------------------
# Installer Script for ZRAM
# -----------------------------------------------------------------------------
#

                   
echo
echo ' _________      _    __  __ '
echo '|__  /  _ \    / \  |  \/  |'
echo '  / /| |_) |  / _ \ | |\/| |'
echo ' / /_|  _ <  / ___ \| |  | |'
echo '/____|_| \_\/_/   \_\_|  |_|'
echo 

while true; do
    read -p "Do you want to start the installation now (Y/n): " yn
    case $yn in
        [Yy]* )
            echo "Installation started."
        break;;
        [Nn]* )
            exit;
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done

# -----------------------------------------------------------------------------
# Install zram
# -----------------------------------------------------------------------------

yay --noconfirm -S zram-generator

GENERATOR_CONF=/etc/systemd/zram-generator.conf
if [ -f "${GENERATOR_CONF}" ]; then
    echo "${GENERATOR_CONF} already exists!"
else
    sudo touch "${GENERATOR_CONF}"
    cat <<EOF | sudo tee "${GENERATOR_CONF}"
[zram0]
zram-size = ram / 2
EOF
fi

echo "Done!"
echo "Reboot now and check the installation with free -h"

