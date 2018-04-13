# dotfiles

# first time setup
simply execute:
    ./setup.sh

# Powerline fonts
execute once:
    cd powerline/fonts
    ./install.sh

# updateing
    git pull
    git submodule update

# get latest module
    git submodule -q foreach git pull origin HEAD
