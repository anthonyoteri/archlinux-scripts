#!/bin/bash                   
#
# -----------------------------------------------------------------------------
# Installer Script for TIMESHIFT
# -----------------------------------------------------------------------------
#

                   
echo
echo ' _  ____     ____  __ '
echo '| |/ /\ \   / /  \/  |'
echo '| ` /  \ \ / /| |\/| |'
echo '| . \   \ V / | |  | |'
echo '|_|\_\   \_/  |_|  |_|'
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
# Install packages
# -----------------------------------------------------------------------------

sudo pacman -S \
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

# -----------------------------------------------------------------------------
# Configure libvertd.conf
# -----------------------------------------------------------------------------

LIBVIRTD_CONF=/etc/libvirt/libvirtd.conf
sudo sed -i 's/^#unix_sock_group = .*/unix_sock_group = "libvirt"/' "${LIBVIRTD_CONF}"
sudo sed -i 's/^#unix_sock_rw_perms = .*"/unix_sock_rw_perms = "0770"/' "${LIBVIRTD_CONF}"

# -----------------------------------------------------------------------------
# Add user to the group 
# -----------------------------------------------------------------------------

sudo usermod -a -G kvm,libvirt $(whoami)

# -----------------------------------------------------------------------------
# Start and enable services
# -----------------------------------------------------------------------------

sudo systemctl enable --now libvirtd

# -----------------------------------------------------------------------------
# Add user to qemu.conf
# -----------------------------------------------------------------------------

QEMU_CONF=/etc/libvirt/qemu.conf
sudo sed -i "s/^#user = .*/user = \"$(whoami)\"/" "${QEMU_CONF}"
sudo sed -i "s/^#group = .*/group = \"$(whoami)\"/" "${QEMU_CONF}"
sudo systemctl restart libvirtd

# -----------------------------------------------------------------------------
# Autostart Network
# -----------------------------------------------------------------------------

sudo virsh net-autostart default

echo "Done! Please restart your system with reboot"

