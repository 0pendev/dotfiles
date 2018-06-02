# sleep 20s
killall conky
cd "$HOME/.conky/System_Flair"
conky -c "$HOME/.conky/System_Flair/System_flair" &
