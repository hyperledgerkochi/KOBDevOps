#!/usr/bin/env bash


function ___kobdevops_check_candidates_cache {
	local candidates_cache="$1"
	if [[ -f "$candidates_cache" && -n "$(cat "$candidates_cache")" && -n "$(find "$candidates_cache" -mmin +$((24*60*30)))" ]]; then
		__kobdevops_echo_yellow 'We periodically need to update the local cache. Please run:'
		echo ''
		__kobdevops_echo_no_colour '  $ kob update'
		echo ''
		return 0
	elif [[ -f "$candidates_cache" && -z "$(cat "$candidates_cache")" ]]; then
		__kobdevops_echo_red 'WARNING: Cache is corrupt. KOBDEVOPS can not be used until updated.'
		echo ''
		__kobdevops_echo_no_colour '  $ kob update'
		echo ''
		return 1
	else
		__kobdevops_echo_debug "No update at this time. Using existing cache: $KOBDEVOPS_CANDIDATES_CSV"
		return 0
	fi
}

function ___kobdevops_check_version_cache {
	local version_url
	local version_file="${KOBDEVOPS_DIR}/var/version"

	if [[ "$kobdevops_beta_channel" != "true" && -f "$version_file" && -z "$(find "$version_file" -mmin +$((60*24)))" ]]; then
		__kobdevops_echo_debug "Not refreshing version cache now..."
		KOBDEVOPS_REMOTE_VERSION=$(cat "$version_file")

	else
		__kobdevops_echo_debug "Version cache needs updating..."
		if [[ "$kobdevops_beta_channel" == "true" ]]; then
			__kobdevops_echo_debug "Refreshing version cache with BETA version."
			version_url="${KOBDEVOPS_CANDIDATES_API}/broker/download/kobdevops/version/beta"
		else
			__kobdevops_echo_debug "Refreshing version cache with STABLE version."
			version_url="${KOBDEVOPS_CANDIDATES_API}/broker/download/kobdevops/version/stable"
		fi

		KOBDEVOPS_REMOTE_VERSION=$(__kobdevops_secure_curl_with_timeouts "$version_url")
		if [[ -z "$KOBDEVOPS_REMOTE_VERSION" || -n "$(echo "$KOBDEVOPS_REMOTE_VERSION" | tr '[:upper:]' '[:lower:]' | grep 'html')" ]]; then
			__kobdevops_echo_debug "Version information corrupt or empty! Ignoring: $KOBDEVOPS_REMOTE_VERSION"
			KOBDEVOPS_REMOTE_VERSION="$KOBDEVOPS_VERSION"

		else
			__kobdevops_echo_debug "Overwriting version cache with: $KOBDEVOPS_REMOTE_VERSION"
			echo "${KOBDEVOPS_REMOTE_VERSION}" | tee "$version_file" > /dev/null
		fi
	fi

}
