#!/bin/bash                   
#
# -----------------------------------------------------------------------------
# Installer Script for desktop tools
# -----------------------------------------------------------------------------
#

echo
echo ' ____  _____ ____  _  _______ ___  ____  '
echo '|  _ \| ____/ ___|| |/ /_   _/ _ \|  _ \ '
echo '| | | |  _| \___ \| ` /  | || | | | |_) |'
echo '| |_| | |___ ___) | . \  | || |_| |  __/ '
echo '|____/|_____|____/|_|\_\ |_| \___/|_|    '
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
    alacritty \
    bibata-cursor-theme \
    brave-bin \
    breeze \
    breeze-gtk \
    chromium \
    dunst \
    exa \
    figlet \
    freerdp \
    lxappearance \
    mousepad \
    mpv \
    neovim \
    nitrogen \
    pavucontrol \
    pfetch \
    picom \
    python-click \
    python-pip \
    python-psutil \
    python-rich \
    rofi \
    rofi-calc \
    scrot \
    slock \
    starship \
    thunar \
    ttf-fira-code \
    ttf-firacode-nerd \
    ttf-fira-sans \
    ttf-font-awesome \
    tumbler \
    vlc \
    xdg-desktop-portal-gtk \
    xfce4-power-manager

# -----------------------------------------------------------------------------
# Install pywal to extract colors from wallpaper
# -----------------------------------------------------------------------------

if [ -f /usr/bin/wal ]; then
    echo "pywal already installed"
else
    yay --noconfirm -S pywal
fi

# -----------------------------------------------------------------------------
# Install Hyprlan packages
# -----------------------------------------------------------------------------

yay --noconfirm -S \
    grim \
    slurp \
    swaylock \
    swww \
    waybar

echo "Done!"

                                         

