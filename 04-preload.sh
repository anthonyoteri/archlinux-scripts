#!/bin/bash                   
#
# -----------------------------------------------------------------------------
# Installer Script for TIMESHIFT
# -----------------------------------------------------------------------------
#

                   
echo
echo ' ____  ____  _____ _     ___    _    ____  '
echo '|  _ \|  _ \| ____| |   / _ \  / \  |  _ \ '
echo '| |_) | |_) |  _| | |  | | | |/ _ \ | | | |'
echo '|  __/|  _ <| |___| |__| |_| / ___ \| |_| |'
echo '|_|   |_| \_\_____|_____\___/_/   \_\____/ '
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
# Install preload
# -----------------------------------------------------------------------------

yay --noconfirm -S preload

echo "Done!"

                                           
