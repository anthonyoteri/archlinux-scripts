#!/bin/bash                   
#
# -----------------------------------------------------------------------------
# Installer Script for tmux
# -----------------------------------------------------------------------------
#

echo
echo ' _____ __  __ _   ___  __'
echo '|_   _|  \/  | | | \ \/ /'
echo '  | | | |\/| | | | |\  / '
echo '  | | | |  | | |_| |/  \ '
echo '  |_| |_|  |_|\___//_/\_\'
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
# Install tmux
# -----------------------------------------------------------------------------

yay --noconfirm -S tmux

echo "Done!"

