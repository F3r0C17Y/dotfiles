#!/bin/bash

PWD=$(pwd)
BACKUP=$PWD/backup
update=false

progress_steps=1


function progressBar() 
{
    local progressBar="#"
    for i in $(seq $progress_steps); do
        printf "%s" "${progressBar}"
    done
}


customize_git()
{
    if [ ! -e "$PWD/config/custom/gitconfig" ]; then
        echo "Git configuration"
        echo "-----------------"
        echo -n "Enter your name: "
        read name
        echo -n "Enter your email address: "
        read email
        echo "[user]"             > "$PWD/config/custom/gitconfig"
        echo "  email = $email"   >> "$PWD/config/custom/gitconfig"
        echo "  name = $name"     >> "$PWD/config/custom/gitconfig"
        echo "-----------------"
    fi

}

combine_dotfiles()
{
    local name=$1
    cat "$PWD/config/${name}" > "${HOME}/.${name}"
    if [ -e "$PWD/config/custom/${name}" ]; then
        cat "$PWD/config/custom/${name}" >> "${HOME}/.${name}"
    fi
}

make_dotfiles()
{
    echo "Make backups and create dotfiles"
    mkdir -p $BACKUP
    for file in $PWD/config/*
    do
        filename=$(basename $file)
        if [ "$filename" != "$(basename $0)" ] && [ ! -d "${filename}" ] && [ -e $HOME/.$filename ]; then
            mv -f $HOME/.$filename $BACKUP/
        fi
    done

    combine_dotfiles bash_aliases 
    combine_dotfiles direnvrc 
    combine_dotfiles gitconfig 
    combine_dotfiles tmux.conf 
    combine_dotfiles vimrc
}


git_checkout()
{
    DEST=$1
    REPO=$2
    REV=$3
    (
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
    ) | progressBar
}

init_vim_plugins()
{
    echo -ne "[*] init vim plugins ["
    progress_steps=$(expr 80 / 11)
    mkdir -p ${PWD}/vim/autoload
    mkdir -p ${PWD}/vim/bundle
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

    pushd powerline/fonts/ > /dev/null
    ./install.sh | progressBar
    popd > /dev/null
    echo "]"
}

init_pwn_dbg()
{
    echo "[*] init pwndbg"
    git_checkout pwndbg https://github.com/pwndbg/pwndbg.git stable

    pushd pwndbg
    ./setup.sh
    popd
}

#######################################
# MAIN

if [ ! -e "$PWD/setup.sh" ]; then
    echo "Please start setup.sh inside dotfile repo root!"
    exit -1
fi

while getopts "u" opt; do
  case ${opt} in
    u )
      update=true
      ;;
    \? ) echo "Usage: setup.sh [-u]"
      ;;
  esac
done

customize_git

make_dotfiles

if [ ! -e ${PWD}/vim/autoload ] || [ $update = "true" ]; then
    init_vim_plugins
fi

exit;
if [ ! -e ${PWD}/pwndbg ] || [ $update = "true" ]; then
    init_pwn_dbg
fi

