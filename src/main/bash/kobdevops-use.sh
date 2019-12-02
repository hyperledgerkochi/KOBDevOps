#!/usr/bin/env bash


function __kob_use {
	local candidate version install

	candidate="$1"
	version="$2"
	__kobdevops_check_version_present "$version" || return 1
	__kobdevops_check_candidate_present "$candidate" || return 1
	__kobdevops_determine_version "$candidate" "$version" || return 1

	if [[ ! -d "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/${VERSION}" ]]; then
		echo ""
		__kobdevops_echo_red "Stop! ${candidate} ${VERSION} is not installed."
		return 1
	fi

	# Just update the *_HOME and PATH for this shell.
	__kobdevops_set_candidate_home "$candidate" "$VERSION"

	# Replace the current path for the candidate with the selected version.
	if [[ "$solaris" == true ]]; then
		export PATH=$(echo $PATH | gsed -r "s!${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/([^/]+)!${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/${VERSION}!g")

	elif [[ "$darwin" == true ]]; then
		export PATH=$(echo $PATH | sed -E "s!${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/([^/]+)!${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/${VERSION}!g")

	else
		export PATH=$(echo "$PATH" | sed -r "s!${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/([^/]+)!${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/${VERSION}!g")
	fi

	if [[ ! ( -h "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/current" || -d "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/current" ) ]]; then
		__kobdevops_echo_green "Setting ${candidate} version ${VERSION} as default."
		__kobdevops_link_candidate_version "$candidate" "$VERSION"
	fi

	echo ""
	__kobdevops_echo_green "Using ${candidate} version ${VERSION} in this shell."
}
