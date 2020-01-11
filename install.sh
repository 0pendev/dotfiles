#!/bin/sh
log(){
    echo "$(date) [+] $1" | tee -a ~/installation.log
}

warning(){
    echo "$(date) [!] $1" | tee -a ~/installation.log
}

alias install="sudo zypper in"
alias upgrade="sudo zypper dup"

log "Starting installation $(date)"

log "Updating system"
upgrade

log "Installing wayland graphical environment"
install\
     rofi thunar sway  swaybg evince brightnessctl swaylock lxsession lxappearance xfce4-terminal i3status

# Uncomment to install X server
#log "Installing X.org graphical environment"
#install\
#     i3  lxrandr xinit xorg-x11 xorg-x11-server xfce4-screenshooter xfce4-power-manager 

log "Installing development tools"
install\
     emacs git zsh podman buildah python3-virtualenv python3-devel go

log "Installing reverse tools"
install\
     gdb glibc-32bit

log "Installing radare2 dependencies"
install\
    gcc gcc patch meson


log "Installing gef for gdb"
wget -q -O- https://github.com/hugsy/gef/raw/master/scripts/gef.sh | sh

log "Installing build dependencies for radare2"


log "Installing theme assets"
install\
     qt5ct elementary-icon-theme breeze5-cursors

log "Installing usefull stuff"
install\
    chromium keepassxc telegram-desktop wget htop\
    yubioath-desktop nextcloud-client

log "Installing fonts"
install -t pattern fonts

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
ln -s ~/Documents/dotfiles/git/.gitconfig ~/.gitconfig

log "Installing oh-my-zsh"
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
