# Arch Linux Postinstall Script

Arch Linux post installation customizations by Anthony Oteri

## Installing

After installing Arch Linux, install git with:

~~~sh
sudo pacman -S git
~~~

Then clone this repository:

~~~sh
git clone https://github.com/anthonyoteri/archlinux-scripts.git
cd archlinux-scripts
~~~

Then run the postinstall script

~~~sh
./1-postinstall.sh
~~~

The script will ask a series of questions along the way, allowing you to
customize the installation as desired.  When the script finishes, you will
need to reboot the system for all the changes to take full effect.
