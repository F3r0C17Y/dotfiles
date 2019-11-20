# dotfiles

# first time setup & update
simply execute:
    ./setup.sh

# Troubleshoot
- If vim does not display vim-airline at bottom correctly most of the time a wrong default console font is selected. Select a Powerline Font e.g. Deja Vu Powerline

# ZSH
to make zsh default shell

```
chsh YOURUSER /bin/zsh
```

# GPG Support
cp gnupg/* $HOME/.gnupg/

add to shell
```
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
gpg-connect-agent updatestartuptty /bye
```

This should print all smartcards:
gpg --card-status


# ipython powerline

For powerline status in ipython add the following lines to file
$HOME/.ipython/profile_default/ipython_config.py

```
import sys

if sys.version_info >= (3, 0):
    from powerline.bindings.ipython.since_5 import PowerlinePrompts

    c = get_config()
    c.TerminalInteractiveShell.simple_prompt = False
    c.TerminalInteractiveShell.prompts_class = PowerlinePrompts
```

# Tmux is not activated per default, add tmux line into .bashrc 
```
case $- in
    *i*)
    [ -z "$TMUX" ] && exec tmux
    ;;
esac
```
