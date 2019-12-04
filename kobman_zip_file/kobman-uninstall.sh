#!/usr/bin/env bash


function __kob_uninstall {
	local candidate version current

	candidate="$1"
	version="$2"
	__kobman_check_candidate_present "$candidate" || return 1
	__kobman_check_version_present "$version" || return 1

	current=$(readlink "${KOBMAN_CANDIDATES_DIR}/${candidate}/current" | sed "s_${KOBMAN_CANDIDATES_DIR}/${candidate}/__g")
	if [[ -h "${KOBMAN_CANDIDATES_DIR}/${candidate}/current" && "$version" == "$current" ]]; then
		echo ""
		__kobman_echo_green "Unselecting ${candidate} ${version}..."
		unlink "${KOBMAN_CANDIDATES_DIR}/${candidate}/current"
	fi
	echo ""
	if [ -d "${KOBMAN_CANDIDATES_DIR}/${candidate}/${version}" ]; then
		__kobman_echo_green "Uninstalling ${candidate} ${version}..."
		rm -rf "${KOBMAN_CANDIDATES_DIR}/${candidate}/${version}"
	else
		__kobman_echo_red "${candidate} ${version} is not installed."
	fi
}
