#!/usr/bin/env bash


function __kob_list {
	local candidate="$1"

	if [[ -z "$candidate" ]]; then
		__kobdevops_list_candidates
	else
		__kobdevops_list_versions "$candidate"
	fi
}

function __kobdevops_list_candidates {
	if [[ "$KOBDEVOPS_AVAILABLE" == "false" ]]; then
		__kobdevops_echo_red "This command is not available while offline."
	else
		__kobdevops_page echo "$(__kobdevops_secure_curl "${KOBDEVOPS_CANDIDATES_API}/candidates/list")"
	fi
}

function __kobdevops_list_versions {
	local candidate versions_csv

	candidate="$1"
	versions_csv="$(__kobdevops_build_version_csv "$candidate")"
	__kobdevops_determine_current_version "$candidate"

	if [[ "$KOBDEVOPS_AVAILABLE" == "false" ]]; then
		__kobdevops_offline_list "$candidate" "$versions_csv"
	else
		__kobdevops_echo_no_colour "$(__kobdevops_secure_curl "${KOBDEVOPS_CANDIDATES_API}/candidates/${candidate}/${KOBDEVOPS_PLATFORM}/versions/list?current=${CURRENT}&installed=${versions_csv}")"
	fi
}

function __kobdevops_build_version_csv {
	local candidate versions_csv

	candidate="$1"
	versions_csv=""

	if [[ -d "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}" ]]; then
		for version in $(find "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}" -maxdepth 1 -mindepth 1 \( -type l -o -type d \) -exec basename '{}' \; | sort -r); do
			if [[ "$version" != 'current' ]]; then
				versions_csv="${version},${versions_csv}"
			fi
		done
		versions_csv=${versions_csv%?}
	fi
	echo "$versions_csv"
}

function __kobdevops_offline_list {
	local candidate versions_csv

	candidate="$1"
	versions_csv="$2"

	__kobdevops_echo_no_colour "--------------------------------------------------------------------------------"
	__kobdevops_echo_yellow "Offline: only showing installed ${candidate} versions"
	__kobdevops_echo_no_colour "--------------------------------------------------------------------------------"

	local versions=($(echo ${versions_csv//,/ }))
	for (( i=${#versions} - 1 ; i >= 0  ; i-- )); do
		if [[ -n "${versions[${i}]}" ]]; then
			if [[ "${versions[${i}]}" == "$CURRENT" ]]; then
				__kobdevops_echo_no_colour " > ${versions[${i}]}"
			else
				__kobdevops_echo_no_colour " * ${versions[${i}]}"
			fi
		fi
	done

	if [[ -z "${versions[@]}" ]]; then
		__kobdevops_echo_yellow "   None installed!"
	fi

	__kobdevops_echo_no_colour "--------------------------------------------------------------------------------"
	__kobdevops_echo_no_colour "* - installed                                                                   "
	__kobdevops_echo_no_colour "> - currently in use                                                            "
	__kobdevops_echo_no_colour "--------------------------------------------------------------------------------"
}
