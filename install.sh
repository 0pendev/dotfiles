#!/bin/sh

log(){
    echo "$(date) [+] $1" | tee -a ~/installation.log
}

warning(){
    echo "$(date) [!] $1" | tee -a ~/installation.log
}

alias zin="sudo zypper in -yl"
alias zup="sudo zypper dup -yl"
alias zal="sudo zypper al"

log "Starting installation"

log "Updating system"
zup

log "Locking useless dependencies"
zal patterns-sway pulseaudio alsa

log "Installing wayland graphical environment"
zin\
    swaybg sway waybar swayidle swaylock \
    xdg-desktop-portal-wlr xdg-desktop-portal-kde xdg-desktop-portal-gnome \
    pipewire pipewire-alsa pipewire-pulseaudio thunar\
    brightnessctl powertop gnome-keyring NetworkManager-connection-editor

log "Installing development tools"
zin\
     git zsh podman flatpak buildah

log "Installing theme assets"
zin\
     breeze5-cursors fontawesome-fonts

log "Installing fonts"
zin -t pattern fonts

log "Configuring flatpak for the current user"
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
log "Installing desktop applications"
flatpak install --user -y \
    org.gnu.emacs com.yubico.yubioath me.kozec.syncthingtk org.gnome.Geary\
    ch.protonmail.protonmail-bridge org.keepassxc.KeePassXC org.mozilla.firefox\
    org.signal.Signal org.telegram.desktop

log "Setting up powertop"
sudo systemctl enable powertop
sudo systemctl start powertop

log "Preparing home directory"
mkdir ~/Downloads
mkdir ~/Pictures
mkdir ~/Public
mkdir ~/bin
mkdir ~/Desktop
mkdir ~/Documents

log "Setting up dotfiles"
cd ~/Documents
git clone http://github.com/0pendev/dotfiles
rm -rf ~/.emacs*
mkdir ~/.config
ln -s ~/Documents/dotfiles/alacritty ~/.config
ln -s ~/Documents/dotfiles/sway ~/.config
ln -s ~/Documents/dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/Documents/dotfiles/waybar ~/.config
ln -s ~/Documents/dotfiles/wofi ~/.config
ln -s ~/Documents/dotfiles/containers ~/.config
ln -s ~/Documents/dotfiles/gtk-3.0 ~/.config
ln -s ~/Documents/dotfiles/gtk2/.gtkrc-2.0 ~
ln -s ~/Documents/dotfiles/doom ~/.doom.d

log "Downloading wallpaper"
wget --output-document  ~/Pictures/odin-dark.jpg https://raw.githubusercontent.com/elementary/wallpapers/master/backgrounds/odin-dark.jpg

log "Configure subuids and subgid to support rootless podman"
sudo usermod --add-subuids 10000-65536 $USER
sudo usermod --add-subgid 10000-65536 $USER

log "Installing doom-emacs"
export EMACS="/usr/bin/flatpak run org.gnu.emacs"
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

log "Installing oh-my-zsh"
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
