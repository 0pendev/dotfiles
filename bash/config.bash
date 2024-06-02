export QT_QPA_PLATFORMTHEME=qt6ct

# GPG SSH Auth Configuration
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
echo UPDATESTARTUPTTY | gpg-connect-agent > /dev/null
