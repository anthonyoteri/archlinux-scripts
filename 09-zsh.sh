#!/bin/bash                   
#
# -----------------------------------------------------------------------------
# Installer Script for neofetch
# -----------------------------------------------------------------------------
#

echo
echo ' _________  _   _ '
echo '|__  / ___|| | | |'
echo '  / /\___ \| |_| |'
echo ' / /_ ___) |  _  |'
echo '/____|____/|_| |_|'
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

yay --noconfirm -S zsh 

# -----------------------------------------------------------------------------
# Install the oh-my-zsh script
# -----------------------------------------------------------------------------

bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Done!"

