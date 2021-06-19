#!/bin/bash

printshellcode() {
    objdump -d $1 |grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'
}

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

# Radare2 framework
r2env(){
    current=$(pwd)/$1
    r2current=/home/r2/shared
    home=~
    r2home=/home/r2
    radare2=$home/.local/share/radare2
    r2radare2=$r2home/.local/share/radare2
    projects=$radare2/projects
    r2projects=$r2radare2/projects
    if ! [ -d "$radare2" ];then
	mkdir $radare2
    fi
    if ! [ -d "$projects" ];then
	mkdir $projects
    fi
    sudo podman run --rm \
	-v $projects:$r2projects \
	-v $current:$r2current \
	-it 0pendev/radare2 bash
}

