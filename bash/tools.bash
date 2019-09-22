#!/bin/bash
# Radare2 framework
r2(){
    home=~
    radare2=$home/.local/share/radare2
    projects=$radare2
    if ! [ -d "$radare2" ];then
	mkdir $radare2
    fi
    if ! [ -d "$projects" ];then
	mkdir $projects
    fi
    sudo podman run --rm -v $home/.local/share/radare2/projects:/home/r2/.local/share/radare2/projects -v $1:/home/r2/current -it 0pendev/radare2 bash
}

