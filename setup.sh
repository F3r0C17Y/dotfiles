#!/bin/bash

PWD=$(pwd)
BACKUP=$HOME/dotfile_bak

mkdir -p $BACKUP

for file in $PWD/*
do
    filename=$(basename $file)
    if [[ "$filename" != "$(basename $0)" ]]; then
        mv -f $HOME/.$filename $BACKUP/
        ln -s $PWD/$filename $HOME/.$filename
    fi
done

git submodule init && git submodule update
