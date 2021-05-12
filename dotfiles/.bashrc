# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.

# Aliases
alias v='vim'
alias ls='ls -hF --color=auto'
alias la='ls -ahF --color=auto'
alias ll='ls -hlF --color=auto'
alias lla='ls -alhF --color=auto'
alias ..='cd ..'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Custom Bash Promt
source ${HOME}/.bash.d/theme.sh

# Auto cd
shopt -s autocd
