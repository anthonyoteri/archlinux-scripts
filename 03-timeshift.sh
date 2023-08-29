#!/bin/bash                   
#
# -----------------------------------------------------------------------------
# Installer Script for TIMESHIFT
# -----------------------------------------------------------------------------
#

                   
echo
echo '_____ ___ __  __ _____ ____  _   _ ___ _____ _____ '
echo '|_   _|_ _|  \/  | ____/ ___|| | | |_ _|  ___|_   _|'
echo '  | |  | || |\/| |  _| \___ \| |_| || || |_    | |  '
echo '  | |  | || |  | | |___ ___) |  _  || ||  _|   | |  '
echo '  |_| |___|_|  |_|_____|____/|_| |_|___|_|     |_|  '
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
# Install timeshift
# -----------------------------------------------------------------------------

yay --noconfirm -S timeshift

echo "Done!"

