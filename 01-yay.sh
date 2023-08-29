#!/bin/bash                   
#  _   _  __ _ _   _ 
# | | | |/ _` | | | |
# | |_| | (_| | |_| |
#  \__, |\__,_|\__, |
#  |___/       |___/ 
#
# -----------------------------------------------------------------------------
# Installer Script for Yay
# -----------------------------------------------------------------------------
#

                   
echo
echo ' _   _  __ _ _   _ '
echo '| | | |/ _` | | | |'
echo '| |_| | (_| | |_| |'
echo ' \__, |\__,_|\__, |'
echo ' |___/       |___/ '
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

git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si

echo "Done!"

