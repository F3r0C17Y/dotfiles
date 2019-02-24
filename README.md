# dotfiles

# first time setup & update
simply execute:
    ./setup.sh

# Troubleshoot
- If vim does not display vim-airline at bottom correctly most of the time a wrong default console font is selected. Select a Monospace Font e.g. Deja Vu Powerline


# Tmux is not activated per default, add tmux line into .bashrc 
case $- in
    *i*)
    [ -z "$TMUX" ] && exec tmux
    ;;
esac
