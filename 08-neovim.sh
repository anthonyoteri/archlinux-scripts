#!/bin/bash                   
#
# -----------------------------------------------------------------------------
# Installer Script for neovim
# -----------------------------------------------------------------------------
#

echo
echo ' _   _ _____ _____     _____ __  __ '
echo '| \ | | ____/ _ \ \   / /_ _|  \/  |'
echo '|  \| |  _|| | | \ \ / / | || |\/| |'
echo '| |\  | |__| |_| |\ V /  | || |  | |'
echo '|_| \_|_____\___/  \_/  |___|_|  |_|'
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

yay --noconfirm -S neovim

echo "Done!"
