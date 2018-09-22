# Added transfer command to easily share a file (see transfer.sh)

transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; } 

# Start screen on startup if $SCREEN is defined
if [[ $SCREEN ]];then
    if [[ -z "$STY" ]]; then
	screen -xRR session_name
    fi
fi
if [[ $POWERLINE ]]; then
    function _update_ps1() {
  	PS1="$(~/go/bin/powerline-go -error $?)\n"$'\u2937'" "
    }

    if [ "$TERM" != "linux" ]; then
    	PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
else
    if [[ $OLD ]];then
	PS1="[\u@\h \W]\n"$'\u2937'" "
    else
        export PS1="╭─ [\[\e[36m\]\u\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[36m\]\h\[\e[m\] \[\e[35m\]\W\[\e[m\]]\n│\n╰─── "
    fi
fi

# Golang configuration
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# Pip binary path
export PATH=$PATH:$HOME/.local/bin

# Just useless stuff I like
if hash neofetch 2>/dev/null; then
    neofetch
fi
