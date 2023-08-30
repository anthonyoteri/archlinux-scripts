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
# Configure the postinstall script
# -----------------------------------------------------------------------------

while true; do
    read -p "Swap with zram (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_ZRAM=true
        break;;
        [Nn]* )
            WITH_ZRAM=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done             
while true; do
    read -p "Install preload (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_PRELOAD=true
        break;;
        [Nn]* )
            WITH_PRELOAD=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Install timeshift (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_TIMESHIFT=true
        break;;
        [Nn]* )
            WITH_TIMESHIFT=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Install common system tools (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_COMMON_SYSTEM_TOOLS=true
        break;;
        [Nn]* )
            WITH_COMMON_SYSTEM_TOOLS=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Install zsh as login shell for $(whoami) (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_ZSH=true
        break;;
        [Nn]* )
            WITH_ZSH=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Install true-type fonts (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_FONTS=true
        break;;
        [Nn]* )
            WITH_FONTS=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Install propriatary Microsoft fonts (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_MS_FONTS=true
        break;;
        [Nn]* )
            WITH_MS_FONTS=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Install dotfiles (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_DOTFILES=true
        break;;
        [Nn]* )
            WITH_DOTFILES=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Install compilers, languages, and development libraries (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_DEVTOOLS=true
        break;;
        [Nn]* )
            WITH_DEVTOOLS=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Install QEMU / Libvirtd (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_QEMU=true
        break;;
        [Nn]* )
            WITH_QEMU=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Install Docker (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_DOCKER=true
        break;;
        [Nn]* )
            WITH_DOCKER=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Install desktop applications (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_DESKTOP_APPS=true
        break;;
        [Nn]* )
            WITH_DESKTOP_APPS=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Install Gnome Desktop specific Apps (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_GNOME_APPS=true
        break;;
        [Nn]* )
            WITH_GNOME_APPS=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Install Hyprland specific Apps (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_HYPR_APPS=true
        break;;
        [Nn]* )
            WITH_HYPR_APPS=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done
while true; do
    read -p "Install window manager specific Apps (Y/n): " yn
    case $yn in
        [Yy]* )
            WITH_WM_APPS=true
        break;;
        [Nn]* )
            WITH_WM_APPS=
        break;;
        * )  echo "Please answer yes or no.";;
    esac
done

# -----------------------------------------------------------------------------
# Install yay
# -----------------------------------------------------------------------------


if ! which yay > /dev/null ; then
    echo "Installing yay"
    YAY_HOME=${HOME}/.yay-git
    if [ ! -d "${YAY_HOME}" ]; then
        git clone https://aur.archlinux.org/yay-git.git ${YAY_HOME}
    else
        bash -c "cd ${YAY_HOME} && git checkout origin/master . && git pull"
    fi
    bash -c "cd ${YAY_HOME} && makepkg -si"
fi

# -----------------------------------------------------------------------------
# Install zram
# -----------------------------------------------------------------------------

if [ ! -z "$WITH_ZRAM" ]; then
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
fi

# -----------------------------------------------------------------------------
# Install preload
# -----------------------------------------------------------------------------

if [ ! -z "${WITH_PRELOAD}" ]; then
    yay ${YAY_OPTS} -S preload
fi

# -----------------------------------------------------------------------------
# Install timeshift
# -----------------------------------------------------------------------------

if [ ! -z "${WITH_TIMESHIFT}" ]; then
    yay ${YAY_OPTS} -S timeshift
fi

# -----------------------------------------------------------------------------
# Install common system tools that make CLI life easier
# -----------------------------------------------------------------------------

if [ ! -z "${WITH_COMMON_SYSTEM_TOOLS}" ]; then
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
fi

# -----------------------------------------------------------------------------
# Install shells and set login shell
# -----------------------------------------------------------------------------

if [ ! -z "${WITH_ZSH}" ]; then
    yay ${YAY_OPTS} -S \
        zsh \
        zsh-autosuggestions

    echo "Setting the login shell for $(whoami) to $(which zsh)"
    sudo chsh -s $(which zsh) $(whoami)

    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    if [ ! -z "${WITH_DOTFILES}" ]; then

        # The dotfiles repository requires that some custom plugins and themes
        # are available.  Skip this if we aren't installing the dotfiles.

        OMZ_PLUGIN_DIR=${HOME}/.oh-my-zsh/custom/plugins
        OMZ_THEMES_DIR=${HOME}/.oh-my-zsh/custom/themes

        mkdir -p ${OMZ_PLUGIN_DIR} ${OMZ_THEMES_DIR}

        if [ ! -d ${OMZ_PLUGIN_DIR}/zsh-autosubbestions ]; then
            bash -c "cd ${OMZ_PLUGINS_DIR} && git clone https://github.com/zsh-users/zsh-autosuggestions"
        fi

        if [ ! -d ${OMZ_PLUGINS_DIR}/zsh-completions ]; then
            bash -c "cd ${OMZ_PLUGINS_DIR} && git clone https://github.com/zsh-users/zsh-completions"
        fi

        if [ ! -d ${OMZ_PLUGINS_DIR}/zsh-syntax-hignlighting ]; then
            bash -c "cd ${OMZ_PLUGINS_DIR} && git clone https://github.com/zsh-users/zsh-syntax-highlighting"
        fi

        if [ ! -d ${OMZ_THEMES_DIR}/powerlevel10k ]; then
            bash -c "cd ${OMZ_THEMES_DIR} && git clone https://github.com/romkatv/powerlevel10k.git"
        fi
    fi
fi

# -----------------------------------------------------------------------------
# Install neofetch and it's optional dependencies
# -----------------------------------------------------------------------------

if ! which neofetch > /dev/null ; then
    yay ${YAY_OPTS} -S \
        catimg \
        chafa \
        feh \
        imagemagick \
        libcaca \
        neofetch
fi

# -----------------------------------------------------------------------------
# Install True-Type Fonts
# -----------------------------------------------------------------------------

if [ ! -z "${WITH_FONTS}" ]; then
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
        ttf-proggy-clean \
        ttf-roboto \
        ttf-ubuntu-font-family
fi

if [ ! -z "${WITH_MS_FONTS}" ]; then
    yay ${YAY_OPTS} -S ttf-ms-win11-auto
fi

# -----------------------------------------------------------------------------
# Fetch and install dotfiles
# -----------------------------------------------------------------------------

if [ ! -z "${WITH_DOTFILES}" ]; then
    DOTFILES_HOME=${HOME}/.dotfiles
    CONFIG="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

    if [ ! -d $DOTFILES_HOME ]; then
        git clone --bare https://github.com/anthonyoteri/dotfiles.git $HOME/.dotfiles
    fi
    $CONFIG checkout -f
    $CONFIG submodule update --init
    $CONFIG config --local status.showUntrackedFiles no
fi

# -----------------------------------------------------------------------------
# Install NeoVIM and Tmux
# -----------------------------------------------------------------------------

if ! which nvim > /dev/null ; then
    yay ${YAY_OPTS} -S neovim
fi

if ! which tmux > /dev/null ; then
    yay ${YAY_OPTS} -S tmux
fi

if [ ! -z "${WITH_DOTFILES}" ]; then 
    nvim +qa  # First run of vim after installing dotfiles just errors
    nvim +PlugInstall +PlugClean +qa
fi

# -----------------------------------------------------------------------------
# Install Compilers, Languages, and Libraries used for Development
# -----------------------------------------------------------------------------

if [ ! -z "${WITH_DEVTOOLS}" ]; then
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
fi


# -----------------------------------------------------------------------------
# Optionally install KVM / QEMU
# -----------------------------------------------------------------------------

if [ ! -z "${WITH_QEMU}" ]; then
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
    
    LIBVIRTD_CONF=/etc/libvirt/libvirtd.conf
    sudo sed -i 's/^#unix_sock_group = .*/unix_sock_group = "libvirt"/' "${LIBVIRTD_CONF}"
    sudo sed -i 's/^#unix_sock_rw_perms = .*"/unix_sock_rw_perms = "0770"/' "${LIBVIRTD_CONF}"

    echo "Adding $(whoami) to groups kvm,libvirtd"
    sudo usermod -a -G kvm,libvirt $(whoami)

    sudo systemctl enable --now libvirtd

    QEMU_CONF=/etc/libvirt/qemu.conf
    sudo sed -i "s/^#user = .*/user = \"$(whoami)\"/" "${QEMU_CONF}"
    sudo sed -i "s/^#group = .*/group = \"$(whoami)\"/" "${QEMU_CONF}"

    sudo systemctl restart libvirtd
    sudo virsh net-autostart default
fi

# -----------------------------------------------------------------------------
# Install Docker
# -----------------------------------------------------------------------------

if [ ! -z "${WITH_DOCKER}" ]; then
    yay ${YAY_OPTS} -S \
        docker \
        docker-buildx \
        docker-compose \
        docker-scan
    
    sudo systemctl enable --now docker.service

    echo "Adding $(whoami) to group docker"
    sudo usermod -a -G docker $(whoami)
fi

# -----------------------------------------------------------------------------
# Install Common Desktop Applications
# -----------------------------------------------------------------------------

if [ ! -z "${WITH_DESKTOP_APPS}" ]; then
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
fi

# -----------------------------------------------------------------------------
# Optionally install Gnome / GTK based programs
# -----------------------------------------------------------------------------

if [ ! -z "${WITH_GNOME_APPS}" ]; then
    yay ${YAY_OPTS} -S \
        gnome-shell-extension-dash-to-dock \
        gnome-shell-extension-dash-to-panel
fi

# -----------------------------------------------------------------------------
# Optionally install Hyprland programs
# -----------------------------------------------------------------------------

if [ ! -z "${WITH_HYPR_APPS}" ]; then
    yay ${YAY_OPTS} -S \
        grim \
        slurp \
        swaylock \
        swww \
        waybar
fi

# -----------------------------------------------------------------------------
# Optionally install Other Desktop based programs
# -----------------------------------------------------------------------------

if [ ! -z "${WITH_WM_APPS}" ]; then
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
fi

# -----------------------------------------------------------------------------
# FIN!
# -----------------------------------------------------------------------------

if [ ! -z "${WITH_ZRAM}" -o ! -z "${WITH_QEMU}" ] ; then
    echo "####################################################################"
    echo "#         You must reboot for the changes to take effect           #"
    echo "####################################################################"
    echo
elif [ ! -z "${WITH_DOTFILES}" ]; then
    echo "####################################################################"
    echo "#        You must log out for the changes to take effect           #"
    echo "####################################################################"
    echo
fi
