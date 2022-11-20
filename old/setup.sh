#!/bin/bash


make_dotfiles()
{
    if [ ! -d "$HOME/.tmux" ]; then
        ln -s $PWD/tmux ~/.tmux
    fi
}


init_tmux_plugins()
{
    echo -ne "[*] init tmux plugins ["
    progress_steps=$(expr 80 / 1)
    mkdir -p ${PWD}/tmux/plugins
    git_checkout tmux/plugins/tpm https://github.com/tmux-plugins/tpm master
    echo "]"
}

init_zsh()
{


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

