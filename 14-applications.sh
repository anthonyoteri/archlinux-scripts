#!/bin/bash                   
#
# -----------------------------------------------------------------------------
# Installer Script for desktop tools
# -----------------------------------------------------------------------------
#

echo
echo '    _    ____  ____  _     ___ ____    _  _____ ___ ___  _   _ ____  '
echo '   / \  |  _ \|  _ \| |   |_ _/ ___|  / \|_   _|_ _/ _ \| \ | / ___| '
echo '  / _ \ | |_) | |_) | |    | | |     / _ \ | |  | | | | |  \| \___ \ '
echo ' / ___ \|  __/|  __/| |___ | | |___ / ___ \| |  | | |_| | |\  |___) |'
echo '/_/   \_\_|   |_|   |_____|___\____/_/   \_\_| |___\___/|_| \_|____/ '
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
    adobe-source-code-pro-fonts \
    alacritty \
    ansible \
    arp-scan \
    awesome-terminal-fonts \
    avahi \
    bacon \
    bat-extras \
    brave-bin \
    cargo-nextest \
    dos2unix \
    findutils \
    figlet \
    filelight \
    ffmpeg4.4 \
    flashrom \
    fping \
    git-delta \
    git-lfs \
    github-cli \
    gnu-netcat \
    gnupg \
    httpie \
    imagemagick \
    kitty \
    lnav \
    man-pages \
    mpv \
    mtr \
    net-snmp \
    networkmanager \
    networkmanager-openvpn \
    neovim \
    nfs-utils \
    nodejs \
    nmap \
    openvpn \
    powerline-fonts \
    powertop \
    reflector \
    ripgrep \
    samba \
    smbclient \
    socat \
    tcpdump \
    thunar \
    tree \
    ttf-bitstream-vera \
    ttf-carlito \
    ttf-croscore \
    ttf-fira-code \
    ttf-firacode-nerd \
    ttf-jetbrains-mono \
    ttf-jetbrains-mono-nerd \
    ttf-monoid-nerd \
    ttf-mononoki-nerd \
    ttf-proggy-clean \
    ttf-roboto \
    ttf-ubuntu-font-family \
    vlc \
    wireguard-tools \
    wireless_tools \
    wireshark-cli \
    wget \
    yamllint \
    yt-dlp \
    zsh-autosuggestions

yay --noconfirm -S \
    gnome-shell-extension-dash-to-dock

echo "Done!"

