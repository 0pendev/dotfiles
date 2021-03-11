#!/bin/sh
log(){
    echo "$(date) [+] $1" | tee -a ~/installation.log
}

warning(){
    echo "$(date) [!] $1" | tee -a ~/installation.log
}

alias zin="sudo zypper in -yl"
alias zup="sudo zypper dup -yl"

log "Starting installation $(date)"

log "Updating system"
zup

log "Installing wayland graphical environment"
zin\
     patterns-sway-sway brightnessctl lxsession lxappearance\
     thunar thunar-plugin-archive engrampa

log "Installing development tools"
sudo zyppe in -yl\
     emacs git zsh podman flatpak buildah

log "Installing theme assets"
zin\
     qt5ct breeze5-cursors elementary-wallpapers\
     fontawesome-fonts

log "Installing usefull stuff"
zin\
    NetworkManager-connection-editor powertop xdg-desktop-portal-wlr xdg-desktop-portal-kde

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --user -y \
	org.flameshot.Flameshot org.mozilla.firefox org.gimp.GIMP org.inkscape.Inkscape\
	org.keepassxc.KeePassXC org.signal.Signal org.telegram.desktop org.gtk.Gtk3theme.Flat-Remix-GTK-Blue-Dark-Solid

log "Installing fonts"
zin -t pattern fonts

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
ln -s ~/Documents/dotfiles/alacritty ~/.config
ln -s ~/Documents/dotfiles/sway ~/.config
ln -s ~/Documents/dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/Documents/dotfiles/waybar ~/.config

log "Configure subuids and subgid to support rootless podman"
sudo usermod --add-subuids 10000-65536 $USER
sudo usermod --add-subgid 10000-65536 $USER

log "Installing oh-my-zsh"
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
