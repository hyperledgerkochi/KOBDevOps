#!/usr/bin/env bash


function __kobdevops_check_candidate_present {
	local candidate="$1"

	if [ -z "$candidate" ]; then
		echo ""
		__kobdevops_echo_red "No candidate provided."
		__kob_help
		return 1
	fi
}

function __kobdevops_check_version_present {
	local version="$1"

	if [ -z "$version" ]; then
		echo ""
		__kobdevops_echo_red "No candidate version provided."
		__kob_help
		return 1
	fi
}

function __kobdevops_determine_version {
	local candidate version folder

	candidate="$1"
	version="$2"
	folder="$3"

	if [[ "$KOBDEVOPS_AVAILABLE" == "false" && -n "$version" && -d "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/${version}" ]]; then
		VERSION="$version"

	elif [[ "$KOBDEVOPS_AVAILABLE" == "false" && -z "$version" && -L "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/current" ]]; then
		VERSION=$(readlink "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/current" | sed "s!${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/!!g")

	elif [[ "$KOBDEVOPS_AVAILABLE" == "false" && -n "$version" ]]; then
		__kobdevops_echo_red "Stop! ${candidate} ${version} is not available while offline."
		return 1

	elif [[ "$KOBDEVOPS_AVAILABLE" == "false" && -z "$version" ]]; then
		__kobdevops_echo_red "This command is not available while offline."
		return 1

	else
		if [[ -z "$version" ]]; then
			version=$(__kobdevops_secure_curl "${KOBDEVOPS_CANDIDATES_API}/candidates/default/${candidate}")
		fi

		local validation_url="${KOBDEVOPS_CANDIDATES_API}/candidates/validate/${candidate}/${version}/$(echo $KOBDEVOPS_PLATFORM | tr '[:upper:]' '[:lower:]')"
		VERSION_VALID=$(__kobdevops_secure_curl "$validation_url")
		__kobdevops_echo_debug "Validate $candidate $version for $KOBDEVOPS_PLATFORM: $VERSION_VALID"
		__kobdevops_echo_debug "Validation URL: $validation_url"

		if [[ "$VERSION_VALID" == 'valid' || "$VERSION_VALID" == 'invalid' && -n "$folder" ]]; then
			VERSION="$version"

		elif [[ "$VERSION_VALID" == 'invalid' && -h "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/${version}" ]]; then
			VERSION="$version"

		elif [[ "$VERSION_VALID" == 'invalid' && -d "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/${version}" ]]; then
			VERSION="$version"

		else
	  if [[ -z "$version" ]]; then version="\b"; fi
			echo ""
			__kobdevops_echo_red "Stop! $candidate $version is not available. Possible causes:"
			__kobdevops_echo_red " * $version is an invalid version"
			__kobdevops_echo_red " * $candidate binaries are incompatible with $KOBDEVOPS_PLATFORM"
			__kobdevops_echo_red " * $candidate has not been released yet"
			return 1
		fi
	fi
}
