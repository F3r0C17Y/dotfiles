#!/bin/bash

PWD=$(pwd)
BACKUP=$PWD/backup

git_checkout()
{
    DEST=$1
    REPO=$2
    REV=$3

    if [[ ! -e "$DEST/.git" ]]; then
        git clone $REPO $DEST
    else
        git pull
    fi

    if [[ "x" != "x$REV" ]]; then
        pushd $DEST
        git checkout $REV
        popd
    fi
}


#######################################
# MAIN

if [ ! -e "$PWD/setup.sh" ]; then
    echo "Please start setup.sh inside dotfile repo root!"
    exit -1
fi

echo "Make backups and create dotfiles"
mkdir -p $BACKUP
for file in $PWD/*
do
    filename=$(basename $file)
    if [ "$filename" != "$(basename $0)" ] && [ ! -d "${filename}" ]; then
        mv -f $HOME/.$filename $BACKUP/
        ln -sf $PWD/$filename $HOME/.$filename
    fi
done

if [ ! -e $HOME/.vim ]; then
    ln -sf $PWD/vim $HOME/.vim
fi

echo "Init git modules"
mkdir -p ${PWD}/vim/autoload
mkdir -p ${PWD}/vim/bundle
git_checkout pwndbg https://github.com/pwndbg/pwndbg.git stable
git_checkout vim/autoload/vim-pathogen https://github.com/tpope/vim-pathogen.git master
git_checkout vim/bundle/nerdtree https://github.com/scrooloose/nerdtree.git master
git_checkout vim/bundle/vim-airline https://github.com/bling/vim-airline.git master
git_checkout vim/bundle/vim-airline-themes https://github.com/vim-airline/vim-airline-themes master
git_checkout vim/bundle/vim-fugitive https://github.com/tpope/vim-fugitive.git master
git_checkout vim/bundle/vim-bufferline https://github.com/bling/vim-bufferline.git master
git_checkout vim/bundle/cscope-maps https://github.com/joe-skb7/cscope-maps.git master
git_checkout vim/bundle/vim-tagbar https://github.com/majutsushi/tagbar.git master
git_checkout vim/bundle/vim-better-whitespace https://github.com/ntpeters/vim-better-whitespace.git master
git_checkout powerline/fonts https://github.com/powerline/fonts.git master

if [ ! -e $PWD/vim/autoload/pathogen.vim ]; then
	ln -sf $PWD/vim/autoload/vim-pathogen/autoload/pathogen.vim $PWD/vim/autoload/pathogen.vim
fi

pushd powerline/fonts/
./install.sh
popd

pushd pwndbg
./setup.sh
popd
