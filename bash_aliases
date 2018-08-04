
# additional ls
alias ll='ls -lF --group-directories-first'
alias la='ls -Al --group-directories-first'
alias l='ls -CF --group-directories-first'

# cd shorts
alias ..='cd ..'
alias ...='cd ../..'

# direnv hook
eval "$(direnv hook bash)"

# start gedit independent from shell
g()
{
(pluma $* &)
}

# qtcreator starts'n'open a cmake project directly
qt()
{
(qtcreator CMakeLists.txt &)
}

jj() {
	command journalctl --no-pager $@ | ccze -A | less -R
}
