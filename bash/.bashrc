# Added transfer command to easily share a file (see transfer.sh)

transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; } 

# Export configuration for my org-files

org2pdf(){
    pandoc $1.org -o $1.pdf --template eisvogel --number-sections
}

# Start screen on startup if $SCREEN is defined
if [[ $SCREEN ]];then
    if [[ -z "$STY" ]]; then
	screen -xRR session_name
    fi
fi

if [[ $OLD ]];then
    PS1="[\u@\h \W]\n"$'\u2937'" "
else
    export PS1="╭─ [\[\e[36m\]\u\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[36m\]\h\[\e[m\] \[\e[35m\]\W\[\e[m\]]\n╰─── "
fi

# Golang configuration
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# Pip binary path
export PATH=$PATH:$HOME/.local/bin
