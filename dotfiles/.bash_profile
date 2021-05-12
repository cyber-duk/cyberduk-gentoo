# /etc/skel/.bash_profile

# Add exports from user profile
source ~/.profile

## Automatically start X11 with login on tty1
if shopt -q login_shell; then
	[[ -f ~/.bashrc ]] && source ~/.bashrc
	[[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]] && exec startx
fi
