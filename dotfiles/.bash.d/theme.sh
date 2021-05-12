#/usr/bin/env bash

function __ {
	echo "$@"
}

function __bold {
	next=$1; shift
	out="$(__$next $@)"
	echo "${out:+${out};}1"
}

function __underline {
	next=$1; shift
	out="$(__$next $@)"
	echo "${out:+${out};}4"
}

function __color {
	color=$1; shift
	case "$1" in
		fg|bg) side="$1"; shift ;;
		*) side=fg;;
	esac
	case "$1" in
		normal|bright) mode="$1"; shift;;
		*) mode=normal;;
	esac
	[[ $color == "rgb" ]] && rgb="$1 $2 $3"; shift 3

	next=$1; shift
	out="$(__$next $@)"
	echo "$(__color_${mode}_${side} $(__color_${color} $rgb))${out:+;${out}}"
}

function __color_parse {
	next=$1; shift
	echo "$(__$next $@)"
}

function color {
	echo "$(__color_parse make_ansi $@)"
}

function echo_color {
	echo "$(__color_parse make_echo $@)"
}


black="\[\e[0;30m\]"
red="\[\e[0;31m\]"
green="\[\e[0;32m\]"
yellow="\[\e[0;33m\]"
blue="\[\e[0;34m\]"
purple="\[\e[0;35m\]"
cyan="\[\e[0;36m\]"
white="\[\e[0;37m\]"
orange="\[\e[0;91m\]"

bold_black="\[\e[30;1m\]"
bold_red="\[\e[31;1m\]"
bold_green="\[\e[32;1m\]"
bold_yellow="\[\e[33;1m\]"
bold_blue="\[\e[34;1m\]"
bold_purple="\[\e[35;1m\]"
bold_cyan="\[\e[36;1m\]"
bold_white="\[\e[37;1m\]"
bold_orange="\[\e[91;1m\]"

underline_black="\[\e[30;4m\]"
underline_red="\[\e[31;4m\]"
underline_green="\[\e[32;4m\]"
underline_yellow="\[\e[33;4m\]"
underline_blue="\[\e[34;4m\]"
underline_purple="\[\e[35;4m\]"
underline_cyan="\[\e[36;4m\]"
underline_white="\[\e[37;4m\]"
underline_orange="\[\e[91;4m\]"

background_black="\[\e[40m\]"
background_red="\[\e[41m\]"
background_green="\[\e[42m\]"
background_yellow="\[\e[43m\]"
background_blue="\[\e[44m\]"
background_purple="\[\e[45m\]"
background_cyan="\[\e[46m\]"
background_white="\[\e[47;1m\]"
background_orange="\[\e[101m\]"

normal="\[\e[0m\]"
reset_color="\[\e[39m\]"

THEME_PROMPT_HOST='\H'

SCM_CHECK=${SCM_CHECK:=true}

SCM_THEME_PROMPT_DIRTY=' ✗'
SCM_THEME_PROMPT_CLEAN=' ✓'
SCM_THEME_PROMPT_PREFIX=' |'
SCM_THEME_PROMPT_SUFFIX='|'
SCM_THEME_BRANCH_PREFIX=''
SCM_THEME_TAG_PREFIX='tag:'
SCM_THEME_DETACHED_PREFIX='detached:'
SCM_THEME_BRANCH_TRACK_PREFIX=' → '
SCM_THEME_BRANCH_GONE_PREFIX=' ⇢ '
SCM_THEME_CURRENT_USER_PREFFIX=' ☺︎ '
SCM_THEME_CURRENT_USER_SUFFIX=''
SCM_THEME_CHAR_PREFIX=''
SCM_THEME_CHAR_SUFFIX=''

SCM_GIT_SHOW_DETAILS=${SCM_GIT_SHOW_DETAILS:=true}
SCM_GIT_SHOW_REMOTE_INFO=${SCM_GIT_SHOW_REMOTE_INFO:=auto}
SCM_GIT_IGNORE_UNTRACKED=${SCM_GIT_IGNORE_UNTRACKED:=false}
SCM_GIT_SHOW_CURRENT_USER=${SCM_GIT_SHOW_CURRENT_USER:=false}
SCM_GIT_SHOW_MINIMAL_INFO=${SCM_GIT_SHOW_MINIMAL_INFO:=false}

SCM_GIT='git'
SCM_GIT_CHAR='±'
SCM_GIT_DETACHED_CHAR='⌿'
SCM_GIT_AHEAD_CHAR="↑"
SCM_GIT_BEHIND_CHAR="↓"
SCM_GIT_UNTRACKED_CHAR="?:"
SCM_GIT_UNSTAGED_CHAR="U:"
SCM_GIT_STAGED_CHAR="S:"

SCM_HG='hg'
SCM_HG_CHAR='☿'

SCM_SVN='svn'
SCM_SVN_CHAR='⑆'

SCM_NONE='NONE'
SCM_NONE_CHAR='○'

THEME_SHOW_USER_HOST=${THEME_SHOW_USER_HOST:=false}
USER_HOST_THEME_PROMPT_PREFIX=''
USER_HOST_THEME_PROMPT_SUFFIX=''

function scm {
	if [[ "$SCM_CHECK" = false ]]; then SCM=$SCM_NONE
	elif [[ -f .git/HEAD ]]; then SCM=$SCM_GIT
	elif which git &> /dev/null && [[ -n "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]]; then SCM=$SCM_GIT
	elif [[ -d .hg ]]; then SCM=$SCM_HG
	elif which hg &> /dev/null && [[ -n "$(hg root 2> /dev/null)" ]]; then SCM=$SCM_HG
	elif [[ -d .svn ]]; then SCM=$SCM_SVN
	else SCM=$SCM_NONE
	fi
}

function scm_prompt_char {
	if [[ -z $SCM ]]; then scm; fi
	if [[ $SCM == $SCM_GIT ]]; then SCM_CHAR=$SCM_GIT_CHAR
	elif [[ $SCM == $SCM_HG ]]; then SCM_CHAR=$SCM_HG_CHAR
	elif [[ $SCM == $SCM_SVN ]]; then SCM_CHAR=$SCM_SVN_CHAR
	else SCM_CHAR=$SCM_NONE_CHAR
	fi
}

function scm_prompt_vars {
	scm
	scm_prompt_char
	SCM_DIRTY=0
	SCM_STATE=''
	[[ $SCM == $SCM_GIT ]] && git_prompt_vars && return
	[[ $SCM == $SCM_HG ]] && hg_prompt_vars && return
	[[ $SCM == $SCM_SVN ]] && svn_prompt_vars && return
}

function scm_prompt_info {
	scm
	scm_prompt_char
	scm_prompt_info_common
}

function scm_prompt_char_info {
	scm_prompt_char
	echo -ne "${SCM_THEME_CHAR_PREFIX}${SCM_CHAR}${SCM_THEME_CHAR_SUFFIX}"
	scm_prompt_info_common
}

function scm_prompt_info_common {
	SCM_DIRTY=0
	SCM_STATE=''

	if [[ ${SCM} == ${SCM_GIT} ]]; then
		if [[ ${SCM_GIT_SHOW_MINIMAL_INFO} == true ]]; then
			# user requests minimal git status information
			git_prompt_minimal_info
		else
			# more detailed git status
			git_prompt_info
		fi
		return
	fi

  # TODO: consider adding minimal status information for hg and svn
  [[ ${SCM} == ${SCM_HG} ]] && hg_prompt_info && return
  [[ ${SCM} == ${SCM_SVN} ]] && svn_prompt_info && return
}

# This is added to address bash shell interpolation vulnerability described
# here: https://github.com/njhartwell/pw3nage
function git_clean_branch {
	local unsafe_ref=$(command git symbolic-ref -q HEAD 2> /dev/null)
	local stripped_ref=${unsafe_ref##refs/heads/}
	local clean_ref=${stripped_ref//[^a-zA-Z0-9\/]/-}
	echo $clean_ref
}

function git_prompt_minimal_info {
	local ref
	local status
	local git_status_flags=('--porcelain')
	SCM_STATE=${SCM_THEME_PROMPT_CLEAN}

	if [[ "$(command git config --get bash-it.hide-status)" != "1" ]]; then
		# Get the branch reference
		ref=$(git_clean_branch) || \
			ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
					SCM_BRANCH=${SCM_THEME_BRANCH_PREFIX}${ref}

	# Get the status
	[[ "${SCM_GIT_IGNORE_UNTRACKED}" = "true" ]] && git_status_flags+='-untracked-files=no'
	status=$(command git status ${git_status_flags} 2> /dev/null | tail -n1)

	if [[ -n ${status} ]]; then
		SCM_DIRTY=1
		SCM_STATE=${SCM_THEME_PROMPT_DIRTY}
	fi

	# Output the git prompt
	SCM_PREFIX=${SCM_THEME_PROMPT_PREFIX}
	SCM_SUFFIX=${SCM_THEME_PROMPT_SUFFIX}
	echo -e "${SCM_PREFIX}${SCM_BRANCH}${SCM_STATE}${SCM_SUFFIX}"
	fi
}

function git_status_summary {
	awk '
	BEGIN {
	untracked=0;
	unstaged=0;
	staged=0;
}
{
	if (!after_first && $0 ~ /^##.+/) {
		print $0
		seen_header = 1
	} else if ($0 ~ /^\?\? .+/) {
	untracked += 1
} else {
if ($0 ~ /^.[^ ] .+/) {
	unstaged += 1
}
if ($0 ~ /^[^ ]. .+/) {
	staged += 1
}
}
after_first = 1
}
END {
if (!seen_header) {
	print
}
print untracked "\t" unstaged "\t" staged
}'
}

function git_prompt_vars {
	local details=''
	SCM_STATE=${GIT_THEME_PROMPT_CLEAN:-$SCM_THEME_PROMPT_CLEAN}
	if [[ "$(git config --get bash-it.hide-status)" != "1" ]]; then
		[[ "${SCM_GIT_IGNORE_UNTRACKED}" = "true" ]] && local git_status_flags='-uno'
		local status_lines=$((git status --porcelain ${git_status_flags} -b 2> /dev/null ||
			git status --porcelain ${git_status_flags}    2> /dev/null) | git_status_summary)
					local status=$(awk 'NR==1' <<< "$status_lines")
					local counts=$(awk 'NR==2' <<< "$status_lines")
					IFS=$'\t' read untracked_count unstaged_count staged_count <<< "$counts"
					if [[ "${untracked_count}" -gt 0 || "${unstaged_count}" -gt 0 || "${staged_count}" -gt 0 ]]; then
						SCM_DIRTY=1
						if [[ "${SCM_GIT_SHOW_DETAILS}" = "true" ]]; then
							[[ "${staged_count}" -gt 0 ]] && details+=" ${SCM_GIT_STAGED_CHAR}${staged_count}" && SCM_DIRTY=3
							[[ "${unstaged_count}" -gt 0 ]] && details+=" ${SCM_GIT_UNSTAGED_CHAR}${unstaged_count}" && SCM_DIRTY=2
							[[ "${untracked_count}" -gt 0 ]] && details+=" ${SCM_GIT_UNTRACKED_CHAR}${untracked_count}" && SCM_DIRTY=1
						fi
						SCM_STATE=${GIT_THEME_PROMPT_DIRTY:-$SCM_THEME_PROMPT_DIRTY}
					fi
	fi

	[[ "${SCM_GIT_SHOW_CURRENT_USER}" == "true" ]] && details+="$(git_user_info)"

	SCM_CHANGE=$(git rev-parse --short HEAD 2>/dev/null)

	local ref=$(git_clean_branch)

	if [[ -n "$ref" ]]; then
		SCM_BRANCH="${SCM_THEME_BRANCH_PREFIX}${ref}"
		local tracking_info="$(grep -- "${SCM_BRANCH}\.\.\." <<< "${status}")"
		if [[ -n "${tracking_info}" ]]; then
			[[ "${tracking_info}" =~ .+\[gone\]$ ]] && local branch_gone="true"
			tracking_info=${tracking_info#\#\# ${SCM_BRANCH}...}
				tracking_info=${tracking_info% [*}
							local remote_name=${tracking_info%%/*}
							local remote_branch=${tracking_info#${remote_name}/}
							local remote_info=""
							local num_remotes=$(git remote | wc -l 2> /dev/null)
							[[ "${SCM_BRANCH}" = "${remote_branch}" ]] && local same_branch_name=true
							if ([[ "${SCM_GIT_SHOW_REMOTE_INFO}" = "auto" ]] && [[ "${num_remotes}" -ge 2 ]]) ||
								[[ "${SCM_GIT_SHOW_REMOTE_INFO}" = "true" ]]; then
															remote_info="${remote_name}"
															[[ "${same_branch_name}" != "true" ]] && remote_info+="/${remote_branch}"
														elif [[ ${same_branch_name} != "true" ]]; then
															remote_info="${remote_branch}"
							fi
							if [[ -n "${remote_info}" ]];then
								if [[ "${branch_gone}" = "true" ]]; then
									SCM_BRANCH+="${SCM_THEME_BRANCH_GONE_PREFIX}${remote_info}"
								else
									SCM_BRANCH+="${SCM_THEME_BRANCH_TRACK_PREFIX}${remote_info}"
								fi
							fi
		fi
		SCM_GIT_DETACHED="false"
	else
		local detached_prefix=""
		ref=$(git describe --tags --exact-match 2> /dev/null)
		if [[ -n "$ref" ]]; then
			detached_prefix=${SCM_THEME_TAG_PREFIX}
		else
			ref=$(git describe --contains --all HEAD 2> /dev/null)
			ref=${ref#remotes/}
			[[ -z "$ref" ]] && ref=${SCM_CHANGE}
			detached_prefix=${SCM_THEME_DETACHED_PREFIX}
		fi
		SCM_BRANCH=${detached_prefix}${ref}
		SCM_GIT_DETACHED="true"
	fi

	local ahead_re='.+ahead ([0-9]+).+'
	local behind_re='.+behind ([0-9]+).+'
	[[ "${status}" =~ ${ahead_re} ]] && SCM_BRANCH+=" ${SCM_GIT_AHEAD_CHAR}${BASH_REMATCH[1]}"
	[[ "${status}" =~ ${behind_re} ]] && SCM_BRANCH+=" ${SCM_GIT_BEHIND_CHAR}${BASH_REMATCH[1]}"

	local stash_count="$(git stash list 2> /dev/null | wc -l | tr -d ' ')"
	[[ "${stash_count}" -gt 0 ]] && SCM_BRANCH+=" {${stash_count}}"

	SCM_BRANCH+=${details}

	SCM_PREFIX=${GIT_THEME_PROMPT_PREFIX:-$SCM_THEME_PROMPT_PREFIX}
	SCM_SUFFIX=${GIT_THEME_PROMPT_SUFFIX:-$SCM_THEME_PROMPT_SUFFIX}
}

function svn_prompt_vars {
	if [[ -n $(svn status 2> /dev/null) ]]; then
		SCM_DIRTY=1
		SCM_STATE=${SVN_THEME_PROMPT_DIRTY:-$SCM_THEME_PROMPT_DIRTY}
	else
		SCM_DIRTY=0
		SCM_STATE=${SVN_THEME_PROMPT_CLEAN:-$SCM_THEME_PROMPT_CLEAN}
	fi
	SCM_PREFIX=${SVN_THEME_PROMPT_PREFIX:-$SCM_THEME_PROMPT_PREFIX}
	SCM_SUFFIX=${SVN_THEME_PROMPT_SUFFIX:-$SCM_THEME_PROMPT_SUFFIX}
	SCM_BRANCH=$(svn info 2> /dev/null | awk -F/ '/^URL:/ { for (i=0; i<=NF; i++) { if ($i == "branches" || $i == "tags" ) { print $(i+1); break }; if ($i == "trunk") { print $i; break } } }') || return
	SCM_CHANGE=$(svn info 2> /dev/null | sed -ne 's#^Revision: ##p' )
}

# this functions returns absolute location of .hg directory if one exists
# It starts in the current directory and moves its way up until it hits /.
# If we get to / then no Mercurial repository was found.
# Example:
# - lets say we cd into ~/Projects/Foo/Bar
# - .hg is located in ~/Projects/Foo/.hg
# - get_hg_root starts at ~/Projects/Foo/Bar and sees that there is no .hg directory, so then it goes into ~/Projects/Foo
function get_hg_root {
	local CURRENT_DIR=$(pwd)

	while [ "$CURRENT_DIR" != "/" ]; do
		if [ -d "$CURRENT_DIR/.hg" ]; then
			echo "$CURRENT_DIR/.hg"
			return
		fi

		CURRENT_DIR=$(dirname $CURRENT_DIR)
	done
}

function hg_prompt_vars {
	if [[ -n $(hg status 2> /dev/null) ]]; then
		SCM_DIRTY=1
		SCM_STATE=${HG_THEME_PROMPT_DIRTY:-$SCM_THEME_PROMPT_DIRTY}
	else
		SCM_DIRTY=0
		SCM_STATE=${HG_THEME_PROMPT_CLEAN:-$SCM_THEME_PROMPT_CLEAN}
	fi
	SCM_PREFIX=${HG_THEME_PROMPT_PREFIX:-$SCM_THEME_PROMPT_PREFIX}
	SCM_SUFFIX=${HG_THEME_PROMPT_SUFFIX:-$SCM_THEME_PROMPT_SUFFIX}

	HG_ROOT=$(get_hg_root)

	if [ -f "$HG_ROOT/branch" ]; then
		# Mercurial holds it's current branch in .hg/branch file
		SCM_BRANCH=$(cat "$HG_ROOT/branch")
	else
		SCM_BRANCH=$(hg summary 2> /dev/null | grep branch: | awk '{print $2}')
	fi

	if [ -f "$HG_ROOT/dirstate" ]; then
		# Mercurial holds various information about the working directory in .hg/dirstate file. More on http://mercurial.selenic.com/wiki/DirState
		SCM_CHANGE=$(hexdump -n 10 -e '1/1 "%02x"' "$HG_ROOT/dirstate" | cut -c-12)
	else
		SCM_CHANGE=$(hg summary 2> /dev/null | grep parent: | awk '{print $2}')
	fi
}

function git_user_info {
	# support two or more initials, set by 'git pair' plugin
	SCM_CURRENT_USER=$(git config user.initials | sed 's% %+%')
	# if `user.initials` weren't set, attempt to extract initials from `user.name`
	[[ -z "${SCM_CURRENT_USER}" ]] && SCM_CURRENT_USER=$(printf "%s" $(for word in $(git config user.name | tr 'A-Z' 'a-z'); do printf "%1.1s" $word; done))
	[[ -n "${SCM_CURRENT_USER}" ]] && printf "%s" "$SCM_THEME_CURRENT_USER_PREFFIX$SCM_CURRENT_USER$SCM_THEME_CURRENT_USER_SUFFIX"
}

function user_host_prompt {
	if [[ "${THEME_SHOW_USER_HOST}" = "true" ]]; then
		echo -e "${USER_HOST_THEME_PROMPT_PREFIX}\u@\h${USER_HOST_THEME_PROMPT_SUFFIX}"
	fi
}

# backwards-compatibility
function git_prompt_info {
	git_prompt_vars
	echo -e "${SCM_PREFIX}${SCM_BRANCH}${SCM_STATE}${SCM_SUFFIX}"
}

function svn_prompt_info {
	svn_prompt_vars
	echo -e "${SCM_PREFIX}${SCM_BRANCH}${SCM_STATE}${SCM_SUFFIX}"
}

function hg_prompt_info() {
	hg_prompt_vars
	echo -e "${SCM_PREFIX}${SCM_BRANCH}:${SCM_CHANGE#*:}${SCM_STATE}${SCM_SUFFIX}"
}

function scm_char {
	scm_prompt_char
	echo -e "${SCM_THEME_CHAR_PREFIX}${SCM_CHAR}${SCM_THEME_CHAR_SUFFIX}"
}

function prompt_char {
	scm_char
}


# Returns true if $1 is a shell function.
fn_exists() {
	type $1 | grep -q 'shell function'
}

function safe_append_prompt_command {
	local prompt_re

	# Set OS dependent exact match regular expression
	if [[ ${OSTYPE} == darwin* ]]; then
		# macOS
		prompt_re="[[:<:]]${1}[[:>:]]"
	else
		# Linux, FreeBSD, etc.
		prompt_re="\<${1}\>"
	fi

	# See if we need to use the overriden version
	if [[ $(fn_exists function append_prompt_command_override) ]]; then
		append_prompt_command_override $1
		return
	fi

	if [[ ${PROMPT_COMMAND} =~ ${prompt_re} ]]; then
		return
	elif [[ -z ${PROMPT_COMMAND} ]]; then
		PROMPT_COMMAND="${1}"
	else
		PROMPT_COMMAND="${1};${PROMPT_COMMAND}"
	fi
}

#############
## Parsers ##
#############

____brainy_top_left_parse() {
	ifs_old="${IFS}"
	IFS="|"
	args=( $1 )
	IFS="${ifs_old}"
	if [ -n "${args[3]}" ]; then
		_TOP_LEFT+="${args[2]}${args[3]}"
	fi
	_TOP_LEFT+="${args[0]}${args[1]}"
	if [ -n "${args[4]}" ]; then
		_TOP_LEFT+="${args[2]}${args[4]}"
	fi
	_TOP_LEFT+=" "
}

____brainy_top_right_parse() {
	ifs_old="${IFS}"
	IFS="|"
	args=( $1 )
	IFS="${ifs_old}"
	_TOP_RIGHT+=" "
	if [ -n "${args[3]}" ]; then
		_TOP_RIGHT+="${args[2]}${args[3]}"
	fi
	_TOP_RIGHT+="${args[0]}${args[1]}"
	if [ -n "${args[4]}" ]; then
		_TOP_RIGHT+="${args[2]}${args[4]}"
	fi
	__TOP_RIGHT_LEN=$(( __TOP_RIGHT_LEN + ${#args[1]} + ${#args[3]} + ${#args[4]} + 1 ))
	(( __SEG_AT_RIGHT += 1 ))
}

____brainy_bottom_parse() {
	ifs_old="${IFS}"
	IFS="|"
	args=( $1 )
	IFS="${ifs_old}"
	_BOTTOM+="${args[0]}${args[1]}"
	[ ${#args[1]} -gt 0 ] && _BOTTOM+=" "
}

____brainy_top() {
	_TOP_LEFT=""
	_TOP_RIGHT=""
	__TOP_RIGHT_LEN=0
	__SEG_AT_RIGHT=0

	for seg in ${___BRAINY_TOP_LEFT}; do
		info="$(___brainy_prompt_"${seg}")"
		[ -n "${info}" ] && ____brainy_top_left_parse "${info}"
	done

	___cursor_right="\033[500C"
	_TOP_LEFT+="${___cursor_right}"

	for seg in ${___BRAINY_TOP_RIGHT}; do
		info="$(___brainy_prompt_"${seg}")"
		[ -n "${info}" ] && ____brainy_top_right_parse "${info}"
	done

	[ $__TOP_RIGHT_LEN -gt 0 ] && __TOP_RIGHT_LEN=$(( __TOP_RIGHT_LEN - 1 ))
	___cursor_adjust="\033[${__TOP_RIGHT_LEN}D"
	_TOP_LEFT+="${___cursor_adjust}"

	printf "%s%s" "${_TOP_LEFT}" "${_TOP_RIGHT}"
}

____brainy_bottom() {
	_BOTTOM=""
	for seg in $___BRAINY_BOTTOM; do
		info="$(___brainy_prompt_"${seg}")"
		[ -n "${info}" ] && ____brainy_bottom_parse "${info}"
	done
	printf "\n%s" "${_BOTTOM}"
}

##############
## Segments ##
##############

___brainy_prompt_user_info() {
	color=$bold_blue
	if [ "${THEME_SHOW_SUDO}" == "true" ]; then
		if [ $(sudo -n id -u 2>&1 | grep 0) ]; then
			color=$bold_red
		fi
	fi
	box="[|]"
	info="\u@\H"
	if [ -n "${SSH_CLIENT}" ]; then
		printf "%s|%s|%s|%s" "${color}" "${info}" "${bold_white}" "${box}"
	else
		printf "%s|%s" "${color}" "${info}"
	fi
}

___brainy_prompt_dir() {
	color=$bold_yellow
	box="[|]"
	info="\w"
	printf "%s|%s|%s|%s" "${color}" "${info}" "${bold_white}" "${box}"
}

___brainy_prompt_scm() {
	[ "${THEME_SHOW_SCM}" != "true" ] && return
	color=$bold_green
	box="$(scm_char) "
	info="$(scm_prompt_info)"
	printf "%s|%s|%s|%s" "${color}" "${info}" "${bold_white}" "${box}"
}

___brainy_prompt_exitcode() {
	[ "${THEME_SHOW_EXITCODE}" != "true" ] && return
	color=$bold_purple
	[ "$exitcode" -ne 0 ] && printf "%s|%s" "${color}" "${exitcode}"
}

___brainy_prompt_char() {
	color=$bold_white
	prompt_char="${__BRAINY_PROMPT_CHAR_PS1}"
	printf "%s|%s" "${color}" "${prompt_char}"
}

#########
## cli ##
#########

__brainy_show() {
	typeset _seg=${1:-}
	shift
	export THEME_SHOW_${_seg}=true
}

__brainy_hide() {
	typeset _seg=${1:-}
	shift
	export THEME_SHOW_${_seg}=false
}

_brainy_completion() {
	local cur _action actions segments
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	_action="${COMP_WORDS[1]}"
	actions="show hide"
	segments="exitcode scm sudo"
	case "${_action}" in
		show)
			COMPREPLY=( $(compgen -W "${segments}" -- "${cur}") )
			return 0
			;;
		hide)
			COMPREPLY=( $(compgen -W "${segments}" -- "${cur}") )
			return 0
			;;
	esac

	COMPREPLY=( $(compgen -W "${actions}" -- "${cur}") )
	return 0
}

brainy() {
	typeset action=${1:-}
	shift
	typeset segs=${*:-}
	typeset func
	case $action in
		show)
			func=__brainy_show;;
		hide)
			func=__brainy_hide;;
	esac
	for seg in ${segs}; do
		seg=$(printf "%s" "${seg}" | tr '[:lower:]' '[:upper:]')
		$func "${seg}"
	done
}

complete -F _brainy_completion brainy

###############
## Variables ##
###############

export SCM_THEME_PROMPT_PREFIX=""
export SCM_THEME_PROMPT_SUFFIX=""

export SCM_THEME_PROMPT_DIRTY=" ${bold_red}✗${normal}"
export SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓${normal}"

THEME_SHOW_SUDO=${THEME_SHOW_SUDO:-"true"}
THEME_SHOW_SCM=${THEME_SHOW_SCM:-"true"}
THEME_SHOW_EXITCODE=${THEME_SHOW_EXITCODE:-"true"}

__BRAINY_PROMPT_CHAR_PS1=${THEME_PROMPT_CHAR_PS1:-">"}
__BRAINY_PROMPT_CHAR_PS2=${THEME_PROMPT_CHAR_PS2:-"\\"}

___BRAINY_TOP_LEFT=${___BRAINY_TOP_LEFT:-"user_info dir scm"}
___BRAINY_TOP_RIGHT=${___BRAINY_TOP_RIGHT:-""}
___BRAINY_BOTTOM=${___BRAINY_BOTTOM:-"exitcode char"}

############
## Prompt ##
############

__brainy_ps1() {
	printf "%s%s%s" "$(____brainy_top)" "$(____brainy_bottom)" "${normal}"
}

__brainy_ps2() {
	color=$bold_white
	printf "%s%s%s" "${color}" "${__BRAINY_PROMPT_CHAR_PS2}  " "${normal}"
}

_brainy_prompt() {
	exitcode="$?"

	PS1="$(__brainy_ps1)"
	PS2="$(__brainy_ps2)"
}

safe_append_prompt_command _brainy_prompt
