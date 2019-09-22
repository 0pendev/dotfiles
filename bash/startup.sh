# Screen configuration
export QT_QPA_PLATFORMTHEME=qt5ct

if [ "$(tty)" = "/dev/tty1" ]; then
        exec sway
fi

if [ "$(tty)" = "/dev/tty2" ]; then
        exec startx
fi

