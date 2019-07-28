# Screen configuration
if [ "$(tty)" = "/dev/tty1" ]; then
        exec sway
fi

if [ "$(tty)" = "/dev/tty2" ]; then
        exec startx
fi

# Export configuration for my org-files
org2pdf(){
    pandoc $1 -o $2 --template $3 --number-sections --listings
}

org2ensibs(){
    echo "[+] Starting org2pdf"
    echo "[+] Linking logo.png"
    ln -s ~/.pandoc/ressources/logo.png ./logo.png
    echo "[+] Crating temporary file __report.org"
    cat ~/.pandoc/ressources/eisvogel.headers > __report.org
    cat $1.org >> __report.org
    echo "[+] Generating PDF"
    org2pdf __report.org $1.pdf eisvogel
    echo "[+] Removing temporary file __report.org"
    rm __report.org
    echo "[+] Unlinking logo.png"
    unlink ./logo.png
}

# Pip binary path
export PATH=$PATH:$HOME/.local/bin
