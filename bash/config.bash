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

#Console output
#export PS1="╭─ [\[\e[36m\]\u\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[36m\]\h\[\e[m\] \[\e[35m\]\W\[\e[m\]] \$(__git_ps1 '(%s)')\n╰─── "

# Golang configuration
export DEFAULT_PATH = $PATH
setgopath(){
	export GOPATH=$1
	export PATH=$DEFAULT_PATH:$GOPATH/bin
}

setgopath ~/GO_WORKSPACES/DEFAULT

# Pip binary path
export PATH=$PATH:$HOME/.local/bin
