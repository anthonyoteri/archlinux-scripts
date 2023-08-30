#!/bin/bash                   
#
# -----------------------------------------------------------------------------
# Installer Script for docker
# -----------------------------------------------------------------------------
#

echo
echo ' ____   ___   ____ _  _______ ____  '
echo '|  _ \ / _ \ / ___| |/ / ____|  _ \ '
echo '| | | | | | | |   | ` /|  _| | |_) |'
echo '| |_| | |_| | |___| . \| |___|  _ < '
echo '|____/ \___/ \____|_|\_\_____|_| \_\'
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
# Install dependent packages 
# -----------------------------------------------------------------------------

yay --noconfirm -S \
    docker \
    docker-buildx \
    docker-compose \
    docker-scan

# -----------------------------------------------------------------------------
# Enable and start the docker daemon
# -----------------------------------------------------------------------------

sudo systemctl enable --now docker.service

# -----------------------------------------------------------------------------
# Add the current user to the docker group
# -----------------------------------------------------------------------------

sudo usermod -a -G docker $(whoami)

echo "Done! Please log out and back in to use Docker."

