#!/bin/sh
sudo zypper dup
sudo zypper in -y\
 papirus-icon-theme breeze5-cursors metatheme-adapta-common\
 wget chromium emacs i3 rofi sakura i3status git zsh\
 gnome-font-viewer lxappearance lxrandr thunar\
 bluez xinit xorg-x11 xorg-x11-server htop keepassxc\
 telegram-desktop podman buildah python3-virtualenv\
 go
sudo zypper in -t pattern fonts
mkdir ~/Documents
cd ~/Documents
git clone http://github.com/0pendev/dotfiles
rm -rf ~/.emacs*
ln -s ~/Documents/dotfiles/emacs ~/.emacs.d
mkdir ~/.config
ln -s ~/Documents/dotfiles/i3 ~/.config
ln -s ~/Documents/dotfiles/i3status ~/.config
ln -s ~/Documents/dotfiles/rofi ~/.config
ln -s ~/Documents/dotfiles/sakura ~/.config
ln -s ~/Documents/dotfiles/xorg/.xinitrc ~/.xinitrc
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
mkdir ~/Downloads
cd ~/Downloads
git clone https://github.com/domtronn/all-the-icons.el
echo "Now install the fonts and configure the theme."
git config --global user.email "contact@ffreitas.io"
git config --global user.name "0pendev" 
