export QT_QPA_PLATFORMTHEME=qt5ct

# Sets emacs binary to point to flatpak
export EMACS="/usr/bin/flatpak run org.gnu.emacs"

# Pip binary path
export PATH=$PATH:$HOME/.local/bin

# GPG SSH Auth Configuration
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
echo UPDATESTARTUPTTY | gpg-connect-agent > /dev/null
