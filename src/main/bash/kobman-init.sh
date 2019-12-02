#!/usr/bin/env bash


# set env vars if not set
if [ -z "$KOBDEVOPS_VERSION" ]; then
	export KOBDEVOPS_VERSION="@KOBDEVOPS_VERSION@"
fi

if [ -z "$KOBDEVOPS_CANDIDATES_API" ]; then
	export KOBDEVOPS_CANDIDATES_API="@KOBDEVOPS_CANDIDATES_API@"
fi

if [ -z "$KOBDEVOPS_DIR" ]; then
	export KOBDEVOPS_DIR="$HOME/.kobdevops"
fi

# infer platform
KOBDEVOPS_PLATFORM="$(uname)"
if [[ "$KOBDEVOPS_PLATFORM" == 'Linux' ]]; then
	if [[ "$(uname -m)" == 'i686' ]]; then
		KOBDEVOPS_PLATFORM+='32'
	else
		KOBDEVOPS_PLATFORM+='64'
	fi
fi
export KOBDEVOPS_PLATFORM

# OS specific support (must be 'true' or 'false').
cygwin=false
darwin=false
solaris=false
freebsd=false
case "${KOBDEVOPS_PLATFORM}" in
	CYGWIN*)
		cygwin=true
		;;
	Darwin*)
		darwin=true
		;;
	SunOS*)
		solaris=true
		;;
	FreeBSD*)
		freebsd=true
esac

# Determine shell
zsh_shell=false
bash_shell=false

if [[ -n "$ZSH_VERSION" ]]; then
	zsh_shell=true
else
	bash_shell=true
fi

# Source kobdevops module scripts and extension files.
#
# Extension files are prefixed with 'kobdevops-' and found in the ext/ folder.
# Use this if extensions are written with the functional approach and want
# to use functions in the main kobdevops script. For more details, refer to
# <https://github.com/kobdevops/kobdevops-extensions>.
OLD_IFS="$IFS"
IFS=$'\n'
scripts=($(find "${KOBDEVOPS_DIR}/src" "${KOBDEVOPS_DIR}/ext" -type f -name 'kobdevops-*'))
for f in "${scripts[@]}"; do
	source "$f"
done
IFS="$OLD_IFS"
unset scripts f

# Load the kobdevops config if it exists.
if [ -f "${KOBDEVOPS_DIR}/etc/config" ]; then
	source "${KOBDEVOPS_DIR}/etc/config"
fi

# Create upgrade delay file if it doesn't exist
if [[ ! -f "${KOBDEVOPS_DIR}/var/delay_upgrade" ]]; then
	touch "${KOBDEVOPS_DIR}/var/delay_upgrade"
fi

# set curl connect-timeout and max-time
if [[ -z "$kobdevops_curl_connect_timeout" ]]; then kobdevops_curl_connect_timeout=7; fi
if [[ -z "$kobdevops_curl_max_time" ]]; then kobdevops_curl_max_time=10; fi

# set curl retry
if [[ -z "${kobdevops_curl_retry}" ]]; then kobdevops_curl_retry=0; fi

# set curl retry max time in seconds
if [[ -z "${kobdevops_curl_retry_max_time}" ]]; then kobdevops_curl_retry_max_time=60; fi

# set curl to continue downloading automatically
if [[ -z "${kobdevops_curl_continue}" ]]; then kobdevops_curl_continue=true; fi

# Read list of candidates and set array
KOBDEVOPS_CANDIDATES_CACHE="${KOBDEVOPS_DIR}/var/candidates"
KOBDEVOPS_CANDIDATES_CSV=$(<"$KOBDEVOPS_CANDIDATES_CACHE")
__kobdevops_echo_debug "Setting candidates csv: $KOBDEVOPS_CANDIDATES_CSV"
if [[ "$zsh_shell" == 'true' ]]; then
	KOBDEVOPS_CANDIDATES=(${(s:,:)KOBDEVOPS_CANDIDATES_CSV})
else
	OLD_IFS="$IFS"
	IFS=","
        KOBDEVOPS_CANDIDATES=(${KOBDEVOPS_CANDIDATES_CSV})
	IFS="$OLD_IFS"
fi

export KOBDEVOPS_CANDIDATES_DIR="${KOBDEVOPS_DIR}/candidates"

for candidate_name in "${KOBDEVOPS_CANDIDATES[@]}"; do
	candidate_dir="${KOBDEVOPS_CANDIDATES_DIR}/${candidate_name}/current"
	if [[ -h "$candidate_dir" || -d "${candidate_dir}" ]]; then
		__kobdevops_export_candidate_home "$candidate_name" "$candidate_dir"
		__kobdevops_prepend_candidate_to_path "$candidate_dir"
	fi
done
unset OLD_IFS candidate_name candidate_dir
export PATH
