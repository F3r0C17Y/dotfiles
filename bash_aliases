
# additional ls
alias ll='ls -lF --group-directories-first'
alias la='ls -Al --group-directories-first'
alias l='ls -CF --group-directories-first'

# cd shorts
alias ..='cd ..'
alias ...='cd ../..'

# start gedit independent from shell
g()
{
(gvim $* &)
}

# qtcreator starts'n'open a cmake project directly
qt()
{
(qtcreator CMakeLists.txt &)
}

journal() {
	command journalctl --no-pager $@ | ccze -A | less -R
}
