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
    pipewire pipewire-libjack-0_3 pipewire-alsa pipewire-pulseaudio \
    brightnessctl powertop gnome-keyring NetworkManager-connection-editor

log "Installing development tools"
zin\
     git zsh podman flatpak buildah

log "Installing theme assets"
zin\
     papirus-icon-theme fontawesome-fonts

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
ln -s ~/Documents/dotfiles/containers ~/.config/containers

log "Downloading catppuccin ressource"
warning "Dotfiles are not fully migrated from flat-remox yet"
THEME=~/Documents/catppuccun
mkdir $THEME
git clone https://github.com/catppuccin/alacritty $THEME/alacritty
git clone https://github.com/catppuccin/gtk $THEME/gtk
git clone https://github.com/catppuccin/cursors $THEME/cursors
git clone https://github.com/catppuccin/papirus-folders $THEME/papirus-folders
git clone https://github.com/catppuccin/nvim $THEME/nvim
git clone https://github.com/catppuccin/wallpapers $THEME/wallpapers
git clone https://github.com/catppuccin/duckduckgo $THEME/duckduckgo
git clone https://github.com/catppuccin/telegram $THEME/telegram
git clone https://github.com/catppuccin/firefox $THEME/firefox
git clone https://github.com/refi64/stylepak $THEME/stylepak

log "Configure subuids and subgid to support rootless podman"
sudo usermod --add-subuids 10000-65536 $USER
sudo usermod --add-subgid 10000-65536 $USER

log "Installing doom-emacs"
export EMACS="/usr/bin/flatpak run org.gnu.emacs"
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

log "Installing oh-my-zsh"
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
