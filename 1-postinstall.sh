#!/bin/bash

###############################################################################
#  Arch Linux Postinstall script
# 
#  By: Anthony Oteri
#
###############################################################################

clear
echo '    _             _     _     _                  '
echo '   / \   _ __ ___| |__ | |   (_)_ __  _   ___  __'
echo '  / _ \ | `__/ __| `_ \| |   | | `_ \| | | \ \/ /'
echo ' / ___ \| | | (__| | | | |___| | | | | |_| |>  < '
echo '/_/   \_\_|  \___|_| |_|_____|_|_| |_|\__,_/_/\_\'
echo                                     
echo ' ____           _   _           _        _ _ '
echo '|  _ \ ___  ___| |_(_)_ __  ___| |_ __ _| | |'
echo '| |_) / _ \/ __| __| | `_ \/ __| __/ _` | | |'
echo '|  __/ (_) \__ \ |_| | | | \__ \ || (_| | | |'
echo '|_|   \___/|___/\__|_|_| |_|___/\__\__,_|_|_|'
echo


YAY_OPTS="--noconfirm --batchinstall --norebuild --sudoloop"

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
# Install yay
# -----------------------------------------------------------------------------

echo "Installing yay"
YAY_HOME=${HOME}/.yay-git
if [ ! -d "${YAY_HOME}" ]; then
    git clone https://aur.archlinux.org/yay-git.git ${YAY_HOME}
else
    bash -c "cd ${YAY_HOME} && git checkout origin/master . && git pull"
fi
bash -c "cd ${YAY_HOME} && makepkg -si"

# -----------------------------------------------------------------------------
# Install zram
# -----------------------------------------------------------------------------

yay ${YAY_OPTS} -S zram-generator

GENERATOR_CONF=/etc/systemd/zram-generator.conf
if [ -f "${GENERATOR_CONF}" ]; then
    echo "${GENERATOR_CONF} already exists!"
else
    sudo touch "${GENERATOR_CONF}"
    cat <<EOF | sudo tee "${GENERATOR_CONF}"
[zram0]
zram-size = ram / 2
EOF
fi

echo "*************************************************************************"
echo "* ZRAM has been installed:  Reboot required for changes to take effect. *"
echo "*************************************************************************"

# -----------------------------------------------------------------------------
# Install preload
# -----------------------------------------------------------------------------

yay ${YAY_OPTS} -S preload

# -----------------------------------------------------------------------------
# Install timeshift
# -----------------------------------------------------------------------------

yay ${YAY_OPTS} -S timeshift

# -----------------------------------------------------------------------------
# Install common system tools that make CLI life easier
# -----------------------------------------------------------------------------

yay ${YAY_OPTS} -S \
    bat \
    bat-extras \
    curl \
    dos2unix \
    dust \
    exa \
    git \
    man-pages \
    ripgrep \
    powertop \
    tree \
    wget

# -----------------------------------------------------------------------------
# Install shells and set login shell
# -----------------------------------------------------------------------------

yay ${YAY_OPTS} -S \
    bash \
    fish \
    zsh

yay ${YAY_OPTS} -S \
    zsh-autosuggestions

echo "Setting the login shell for $(whoami) to $(which zsh)"
sudo chsh -s $(which zsh) $(whoami)

bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

OMZ_PLUGIN_DIR=${HOME}/.oh-my-zsh/custom/plugins
OMZ_THEMES_DIR=${HOME}/.oh-my-zsh/custom/themes

mkdir -p ${OMZ_PLUGIN_DIR} ${OMZ_THEMES_DIR}

test -d ${OMZ_PLUGINS_DIR}/zsh-autosuggestions || \
    bash -c "cd ${OMZ_PLUGINS_DIR} && git clone https://github.com/zsh-users/zsh-autosuggestions"

test -d ${OMZ_PLUGINS_DIR}/zsh-completions || \
    bash -c "cd ${OMZ_PLUGINS_DIR} && git clone https://github.com/zsh-users/zsh-completions"

test -d ${OMZ_PLUGINS_DIR}/zsh-syntax-hignlighting || \
    bash -c "cd ${OMZ_PLUGINS_DIR} && git clone https://github.com/zsh-users/zsh-syntax-highlighting"

test -d ${OMZ_THEMES_DIR}/powerlevel10k || \
    bash -c "cd ${OMZ_THEMES_DIR} && git clone https://github.com/romkatv/powerlevel10k.git"
    
# -----------------------------------------------------------------------------
# Install neofetch and it's optional dependencies
# -----------------------------------------------------------------------------

yay ${YAY_OPTS} -S \
    catimg \
    chafa \
    feh \
    imagemagick \
    libcaca \
    neofetch

# -----------------------------------------------------------------------------
# Install True-Type Fonts
# -----------------------------------------------------------------------------

yay ${YAY_OPTS} -S \
    adobe-source-code-pro-fonts \
    awesome-terminal-fonts \
    powerline-fonts \
    ttf-bitstream-vera \
    ttf-carlito \
    ttf-croscore \
    ttf-fira-code \
    ttf-fira-sans \
    ttf-firacode-nerd \
    ttf-font-awesome \
    ttf-jetbrains-mono \
    ttf-jetbrains-mono-nerd \
    ttf-monoid-nerd \
    ttf-mononoki-nerd \
    ttf-ms-win11-auto \
    ttf-proggy-clean \
    ttf-roboto \
    ttf-ubuntu-font-family \

# -----------------------------------------------------------------------------
# Fetch and install dotfiles
# -----------------------------------------------------------------------------

DOTFILES_HOME=${HOME}/.dotfiles
CONFIG="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

if [ ! -d $DOTFILES_HOME ]; then
    git clone --bare https://github.com/anthonyoteri/dotfiles.git $HOME/.dotfiles
fi
$CONFIG checkout -f
$CONFIG submodule update --init
$CONFIG config --local status.showUntrackedFiles no

# -----------------------------------------------------------------------------
# Install NeoVIM and Tmux
# -----------------------------------------------------------------------------

yay ${YAY_OPTS} -S \
    neovim \
    tmux

nvim +qa  # First run of vim after installing dotfiles just errors
nvim +PlugInstall +PlugClean +qa

# -----------------------------------------------------------------------------
# Install Compilers, Languages, and Libraries used for Development
# -----------------------------------------------------------------------------

yay ${YAY_OPTS} -S \
    ansible \
    base-devel \
    cargo-nextest \
    cmake \
    git-delta \
    git-lfs \
    jdk8-openjdk \
    jre17-openjdk \
    nlohmann-json \
    nodejs \
    python \
    rust-analyzer \
    rust


# -----------------------------------------------------------------------------
# Optionally install KVM / QEMU
# -----------------------------------------------------------------------------

while true; do
    read -p "Do you want to install KVM (Y/n): " yn
    case $yn in
        [Yy]* )
            echo "Installation started."
            yay ${YAY_OPTS} -S \
                virt-manager \
                virt-viewer \
                qemu \
                vde2 \
                ebtables \
                iptables-nft \
                nftables \
                dnsmasq \
                bridge-utils \
                ovmf \
                swtpm
            
            echo "Configuring libvirtd"
            LIBVIRTD_CONF=/etc/libvirt/libvirtd.conf
            sudo sed -i 's/^#unix_sock_group = .*/unix_sock_group = "libvirt"/' "${LIBVIRTD_CONF}"
            sudo sed -i 's/^#unix_sock_rw_perms = .*"/unix_sock_rw_perms = "0770"/' "${LIBVIRTD_CONF}"

            echo "Adding $(whoami) to groups kvm,libvirtd"
            sudo usermod -a -G kvm,libvirt $(whoami)

            echo "Starting and enabling libvirtd now"
            sudo systemctl enable --now libvirtd

            echo "Configuring QEMU"
            QEMU_CONF=/etc/libvirt/qemu.conf
            sudo sed -i "s/^#user = .*/user = \"$(whoami)\"/" "${QEMU_CONF}"
            sudo sed -i "s/^#group = .*/group = \"$(whoami)\"/" "${QEMU_CONF}"

            echo "Restarting libvirtd"
            sudo systemctl restart libvirtd

            echo "Configuring network to autostart"
            sudo virsh net-autostart default
        break;;
        [Nn]* )
            echo "Skipping installation of KVM"
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done

# -----------------------------------------------------------------------------
# Optionally install Docker
# -----------------------------------------------------------------------------

while true; do
    read -p "Do you want to install Docker (Y/n): " yn
    case $yn in
        [Yy]* )
            echo "Installation started."
            yay ${YAY_OPTS} -S \
                docker \
                docker-buildx \
                docker-compose \
                docker-scan
            
            echo "Starting and enabling docker now"
            sudo systemctl enable --now docker.service

            echo "Adding $(whoami) to group docker"
            sudo usermod -a -G docker $(whoami)
        break;;
        [Nn]* )
            echo "Skipping installation of Docker"
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done

# -----------------------------------------------------------------------------
# Install Common Desktop Applications
# -----------------------------------------------------------------------------

yay ${YAY_OPTS} -S \
    alacritty \
    arp-scan \
    avahi \
    bacon \
    brave-bin \
    figlet \
    filelight \
    ffmpeg4.4 \
    fping \
    github-cli \
    gnupg \
    httpie \
    kitty \
    lnav \
    mpv \
    mtr \
    networkmanager-openvpn \
    nfs-utils \
    nmap \
    openvpn \
    reflector \
    samba \
    smbclient \
    socat \
    tcpdump \
    vlc \
    wireguard-tools \
    wireless_tools \
    wireshark-cli \
    wget \
    yamllint \
    yt-dlp

# -----------------------------------------------------------------------------
# Optionally install Gnome / GTK based programs
# -----------------------------------------------------------------------------

while true; do
    read -p "Do you want to install programs for Gnome (Y/n): " yn
    case $yn in
        [Yy]* )
            echo "Installation started."
            yay ${YAY_OPTS} -S \
                gnome-shell-extension-dash-to-dock \
                gnome-shell-extension-dash-to-panel
        break;;
        [Nn]* )
            echo "Skipping installation of programs for Gnome"
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done

# -----------------------------------------------------------------------------
# Optionally install Hyprland programs
# -----------------------------------------------------------------------------

while true; do
    read -p "Do you want to install programs for Hyprland (Y/n): " yn
    case $yn in
        [Yy]* )
            echo "Installation started."
            yay ${YAY_OPTS} -S \
                grim \
                slurp \
                swaylock \
                swww \
                waybar
        break;;
        [Nn]* )
            echo "Skipping installation of programs for Hyprland"
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done

# -----------------------------------------------------------------------------
# Optionally install Other Desktop based programs
# -----------------------------------------------------------------------------

while true; do
    read -p "Do you want to install programs for Other (Y/n): " yn
    case $yn in
        [Yy]* )
            echo "Installation started."
            yay ${YAY_OPTS} -S \
                dunst \
                lxappearance \
                mousepad \
                nitrogen \
                pavucontrol \
                pywal \
                rofi \
                rofi-calc \
                thunar \
                xdg-desktop-portal-gtk \
                xfce4-power-manager
        break;;
        [Nn]* )
            echo "Skipping installation of programs for other"
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done

# -----------------------------------------------------------------------------
# FIN!
# -----------------------------------------------------------------------------

echo "########################################################################"
echo "# Arch linux postinstall script is now complete.                       #"
echo "#                                                                      #"
echo "# You may need to reboot for the changes to take effect.               #"
echo "########################################################################"
echo
