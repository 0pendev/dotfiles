# Added transfer command to easily share a file (see transfer.sh)
transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; } 

# Export configuration for my org-files
org2pdf(){
    pandoc $1 -o $2 --template $3 --number-sections --listings
}

org2ensibs(){
    echo "[INFO] Starting org2pdf"
    echo "[INFO] Linking logo.png"
    ln -s ~/.pandoc/ressources/logo.png ./logo.png
    echo "[INFO] Crating temporary file __report.org"
    cat ~/.pandoc/ressources/eisvogel.headers > __report.org
    cat $1.org >> __report.org
    echo "[INFO] Generating PDF"
    org2pdf __report.org $1.pdf eisvogel
    echo "[INFO] Removing temporary file __report.org"
    rm __report.org
    echo "[INFO] Unlinking logo.png"
    unlink ./logo.png
}

# Start screen on startup if $SCREEN is defined
if [[ $SCREEN ]];then
    if [[ -z "$STY" ]]; then
	screen -xRR session_name
    fi
fi

#Console output
#export PS1="╭─ [\[\e[36m\]\u\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[36m\]\h\[\e[m\] \[\e[35m\]\W\[\e[m\]] \$(__git_ps1 '(%s)')\n╰─── "

# Golang configuration
export PATH=$PATH:/usr/local/go/bin
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

# Pip binary path
export PATH=$PATH:$HOME/.local/bin
