#!/usr/bin/env bash


function __kob_uninstall {
	local candidate version current

	candidate="$1"
	version="$2"
	__kobdevops_check_candidate_present "$candidate" || return 1
	__kobdevops_check_version_present "$version" || return 1

	current=$(readlink "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/current" | sed "s_${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/__g")
	if [[ -h "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/current" && "$version" == "$current" ]]; then
		echo ""
		__kobdevops_echo_green "Unselecting ${candidate} ${version}..."
		unlink "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/current"
	fi
	echo ""
	if [ -d "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/${version}" ]; then
		__kobdevops_echo_green "Uninstalling ${candidate} ${version}..."
		rm -rf "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/${version}"
	else
		__kobdevops_echo_red "${candidate} ${version} is not installed."
	fi
}
