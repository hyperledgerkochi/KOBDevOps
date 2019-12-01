#!/usr/bin/env bash


function __kob_default {
	local candidate version

	candidate="$1"
	version="$2"

	__kobdevops_check_candidate_present "$candidate" || return 1
	__kobdevops_determine_version "$candidate" "$version" || return 1

	if [ ! -d "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/${VERSION}" ]; then
		echo ""
		__kobdevops_echo_red "Stop! ${candidate} ${VERSION} is not installed."
		return 1
	fi

	__kobdevops_link_candidate_version "$candidate" "$VERSION"

	echo ""
	__kobdevops_echo_green "Default ${candidate} version set to ${VERSION}"
}
