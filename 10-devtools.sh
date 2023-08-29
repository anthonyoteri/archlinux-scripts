#!/bin/bash                   
#
# -----------------------------------------------------------------------------
# Installer Script for development tools 
# -----------------------------------------------------------------------------
#

echo
echo ' ____  _______     _______ ___   ___  _     ____  '
echo '|  _ \| ____\ \   / /_   _/ _ \ / _ \| |   / ___| '
echo '| | | |  _|  \ \ / /  | || | | | | | | |   \___ \ '
echo '| |_| | |___  \ V /   | || |_| | |_| | |___ ___) |'
echo '|____/|_____|  \_/    |_| \___/ \___/|_____|____/ '
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
# Install vscode
# -----------------------------------------------------------------------------

yay --noconfirm -S visual-studio-code-bin

# -----------------------------------------------------------------------------
# Install build tools and compilers
# -----------------------------------------------------------------------------

yay --noconfirm -S \
    base-devel \
    goenv \
    pyenv \
    rustup

echo "Done!"

# -----------------------------------------------------------------------------
# Setup latest stable rust compiler
# -----------------------------------------------------------------------------

rustup install stable

# -----------------------------------------------------------------------------
# Install python interpreters
# -----------------------------------------------------------------------------

pyenv install 2.7
pyenv install 3.6
pyenv install 3.8
pyenv install 3.12
