#!/bin/bash                   
#
# -----------------------------------------------------------------------------
# Installer Script for neofetch
# -----------------------------------------------------------------------------
#

echo
echo ' _   _ _____ ___  _____ _____ _____ ____ _   _ '
echo '| \ | | ____/ _ \|  ___| ____|_   _/ ___| | | |'
echo '|  \| |  _|| | | | |_  |  _|   | || |   | |_| |'
echo '| |\  | |__| |_| |  _| | |___  | || |___|  _  |'
echo '|_| \_|_____\___/|_|   |_____| |_| \____|_| |_|'
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
# Install exa
# -----------------------------------------------------------------------------

yay --noconfirm -S \
    catimg \
    chafa \
    feh \
    imagemagick \
    libcaca \
    nitrogen \
    neofetch \
    w3m

echo "Done!"

