#!/bin/bash                   
#
# -----------------------------------------------------------------------------
# Installer Script for EXA
# -----------------------------------------------------------------------------
#

echo
echo ' ____    _  _____ '
echo '| __ )  / \|_   _|'
echo '|  _ \ / _ \ | |  '
echo '| |_) / ___ \| |  '
echo '|____/_/   \_\_|  '
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

yay --noconfirm -S bat

echo "Done!"

