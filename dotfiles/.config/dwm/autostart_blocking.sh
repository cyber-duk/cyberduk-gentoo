#!/bin/bash

function _run() {
	if which "$1"; then
		if ! pidof "$1"; then
			"$@" >/dev/null 2>&1 &
		fi
	fi
}

# launch programs
_run numlockx
_run feh --no-fehbg --randomize --bg-scale ~/Pictures/Wallhaven/
_run aslstatus
_run dunst
_run mpd
_run greenclip daemon

if which dunst; then
	notify-send "System" "DWM started successfully."
fi
