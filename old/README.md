# dotfiles

# GPG Support
`cp gnupg/* $HOME/.gnupg/`

Add the following lines at end of your `/etc/profile` not .bashrc or .zshrc!
```
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
gpg-connect-agent updatestartuptty /bye >/dev/null
```

This should print all smartcards:
```
gpg --card-status
```

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




# ALE Vim Plugin

```bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .

ninja -t compdb > compile_commands.json
```

# Rust tools

```
cargo install alacritty
cargo install exa
cargo install bandwhich
cargo install ripgrep
cargo install starship
```
