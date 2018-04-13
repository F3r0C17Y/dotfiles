#!/bin/bash

PWD=$(pwd)
BACKUP=$HOME/dotfile_bak

echo "Make backups and create dotfiles"
mkdir -p $BACKUP
for file in $PWD/*
do
    filename=$(basename $file)
    if [ "$filename" != "$(basename $0)" ] && [ ! -d "${filename}" ]; then
        mv -f $HOME/.$filename $BACKUP/
        ln -s $PWD/$filename $HOME/.$filename
    fi
done

if [ ! -e $HOME/.vim ]; then
    ln -sf $PWD/vim $HOME/.vim
fi

echo "Init and update Submodules"
git submodule init && git submodule update

ln -sf $PWD/vim/autoload/vim-pathogen/autoload/pathogen.vim $PWD/vim/autoload/pathogen.vim 

pushd powerline/fonts/
./install.sh
popd

pushd pwndbg
./setup.sh
popd
