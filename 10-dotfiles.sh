#!/bin/bash                   
#
# -----------------------------------------------------------------------------
# Installer Script for dotfiles
# -----------------------------------------------------------------------------
#

echo
echo ' ____   ___ _____ _____ ___ _     _____ ____  '
echo '|  _ \ / _ \_   _|  ___|_ _| |   | ____/ ___| '
echo '| | | | | | || | | |_   | || |   |  _| \___ \ '
echo '| |_| | |_| || | |  _|  | || |___| |___ ___) |'
echo '|____/ \___/ |_| |_|   |___|_____|_____|____/ '
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
# Install dotfiles 
# -----------------------------------------------------------------------------

git clone --bare https://github.com/anthonyoteri/dotfiles.git $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config checkout
config config --local status.showUntrackedFiles no

echo "Done!"

                                              
