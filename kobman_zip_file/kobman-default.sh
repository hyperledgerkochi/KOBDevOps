#!/usr/bin/env bash


function __kob_default {
	local candidate version

	candidate="$1"
	version="$2"

	__kobman_check_candidate_present "$candidate" || return 1
	__kobman_determine_version "$candidate" "$version" || return 1

	if [ ! -d "${KOBMAN_CANDIDATES_DIR}/${candidate}/${VERSION}" ]; then
		echo ""
		__kobman_echo_red "Stop! ${candidate} ${VERSION} is not installed."
		return 1
	fi

	__kobman_link_candidate_version "$candidate" "$VERSION"

	echo ""
	__kobman_echo_green "Default ${candidate} version set to ${VERSION}"
}
