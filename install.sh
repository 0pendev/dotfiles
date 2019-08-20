#!/bin/sh
log(){
    echo "[+] $1" | tee -a ~/installation.log
}

warning(){
    echo "[!] $1" | tee -a ~/installation.log
}


log "[+] Starting installation $(date)"
log "Updating system"
sudo zypper dup
log "Installing graphical environment and development tools"
sudo zypper in\
     paper-icon-theme metatheme-paper-common breeze5-cursors\
     wget chromium emacs i3 rofi sakura i3status git zsh\
     gnome-font-viewer lxappearance lxrandr nemo\
     bluez xinit xorg-x11 xorg-x11-server htop keepassxc\
     telegram-desktop podman buildah python3-virtualenv\
     go xfce4-power-manager powertop xfce4-screenshooter\
     lxsession sway evince brightnessctl swaylock

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
log "Installing zsh"
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

