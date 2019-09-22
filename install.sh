#!/bin/sh
log(){
    echo "$(date) [+] $1" | tee -a ~/installation.log
}

warning(){
    echo "$(date) [!] $1" | tee -a ~/installation.log
}


log "Starting installation $(date)"

log "Updating system"
sudo zypper dup

log "Installing wayland graphical environment"
sudo zypper in\
     rofi sakura thunar sway evince brightnessctl swaylock lxsession lxappearance

log "Installing X.org graphical environment"
sudo zypper in\
     i3 i3status lxrandr xinit xorg-x11 xorg-x11-server xfce4-screenshooter xfce4-power-manager 

log "Installing development tools"
sudo zypper in\
     emacs git zsh podman buildah python3-virtualenv go python3-devel

log "Installing reverse tools"
sudo zypper in\
     gdb glibc-32bit

log "Installing theme assets"
sudo zypper in\
     paper-icon-theme metatheme-paper-common breeze5-cursors\
     metatheme-greybird-geeko-common elementary-xfce-icon-theme\
     qt5ct

log "Installing usefull stuff"
sudo zypper in\
     chromium gnome-font-viewer keepassxc telegram-desktop\
     wget htop

log "Installing fonts"
sudo zypper in -t pattern fonts

log "Setting up powertop"
sudo systemctl enable powertop
sudo systemctl start powertop

log "Setting up dotfiles"
mkdir ~/Documents
cd ~/Documents
git clone http://github.com/0pendev/dotfiles
rm -rf ~/.emacs*
ln -s ~/Documents/dotfiles/emacs ~/.emacs.d
mkdir ~/.config
ln -s ~/Documents/dotfiles/i3status ~/.config
ln -s ~/Documents/dotfiles/rofi ~/.config
ln -s ~/Documents/dotfiles/sway ~/.config
ln -s ~/Documents/dotfiles/sakura ~/.config
ln -s ~/Documents/dotfiles/xorg/.xinitrc ~/.xinitrc

log "Downloading all-the-icons"
mkdir ~/Downloads
cd ~/Downloads
git clone https://github.com/domtronn/all-the-icons.el
warning "Now install the fonts and configure the theme."

log "Setting up git globally"
git config --global user.email "contact@ffreitas.io"
git config --global user.name "0pendev"

log "Setting up hostname to r0nd"
sudo log "r0nd" > /etc/hostname

log "Installing oh-my-zsh"
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
