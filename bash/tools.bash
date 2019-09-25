#!/bin/bash
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

