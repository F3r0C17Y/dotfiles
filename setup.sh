#!/bin/bash

PWD=$(pwd)
BACKUP=$HOME/dotfile_bak

mkdir -p $BACKUP

for file in $PWD/*
do
    filename=$(basename $file)
    if [ "$filename" != "$(basename $0)" ] && [ ! -d "${filename}" ]; then
        mv -f $HOME/.$filename $BACKUP/
        ln -s $PWD/$filename $HOME/.$filename
    fi
done

ln -sf $PWD/vim $HOME/.vim

git submodule init && git submodule update

ln -sf $PWD/vim/autoload/vim-pathogen/autoload/pathogen.vim $PWD/vim/autoload/pathogen.vim 
