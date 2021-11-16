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

    if [ ! -d "$HOME/.vim" ]; then
        ln -s $PWD/vim ~/.vim
    fi

    if [ ! -d "$HOME/.config/nvim" ]; then
        ln -s $HOME/.vim $HOME/.config/nvim
        ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
    fi

    if [ ! -e "$HOME/.config/nvim/init.vim" ]; then
        ln -sf $HOME/.vimrc $HOME/.config/nvim/init.vim
    fi



    combine_dotfiles bash_aliases
    combine_dotfiles direnvrc
    combine_dotfiles gitconfig
    combine_dotfiles tmux.conf
    combine_dotfiles vimrc
    combine_dotfiles zshrc

    sed -i "s#REPLACE_DIR_ME#$PWD/powerline/powerline#g" $HOME/.tmux.conf

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
    git_checkout vim/bundle/ale https://github.com/dense-analysis/ale.git master
    git_checkout powerline/fonts https://github.com/powerline/fonts.git master
    git_checkout powerline/powerline https://github.com/powerline/powerline master

    if [ ! -e $PWD/vim/autoload/pathogen.vim ]; then
	    ln -sf $PWD/vim/autoload/vim-pathogen/autoload/pathogen.vim $PWD/vim/autoload/pathogen.vim
    fi


    pushd $PWD/powerline/fonts/ > /dev/null
    ./install.sh
    popd > /dev/null
    echo "]"
}

init_zsh()
{
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

}

init_gef_dbg()
{
    echo "[*] init gef dbg"
    mkdir -p gefdbg
    pushd gefdbg
    wget -q -O "$(pwd)/gdbinit-gef.py" https://github.com/hugsy/gef/raw/master/gef.py
    echo "source $(pwd)/gdbinit-gef.py" > "$HOME/.gdbinit"
    popd
}

#######################################
# MAIN

if [ ! -e "$PWD/setup.sh" ]; then
    echo "Please start setup.sh inside dotfile repo root!"
    exit -1
fi

while getopts "ud" opt; do
  case ${opt} in
    d )
      sudo apt install cmake wget curl git zsh neovim ctags virtualenv virtualenvwrapper tmux tmuxinator powerline scdaemon
      #pip2 install capstone unicorn keystone-engine ropper
      pip3 install capstone unicorn keystone-engine ropper
      ;;
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

if [ ! -e ${PWD}/gef ] || [ $update = "true" ]; then
    init_gef_dbg
fi

if [ ! -e $HOME/.oh-my-zsh ] || [ $update = "true" ]; then
    init_zsh
fi

