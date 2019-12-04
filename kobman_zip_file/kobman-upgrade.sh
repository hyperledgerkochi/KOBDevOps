#!/usr/bin/env bash


function __kob_upgrade {
	local all candidates candidate upgradable installed_count upgradable_count upgradable_candidates
	if [ -n "$1" ]; then
		all=false
		candidates=$1
	else
		all=true
		if [[ "$zsh_shell" == 'true' ]]; then
			candidates=( ${KOBMAN_CANDIDATES[@]} )
		else
			candidates=${KOBMAN_CANDIDATES[@]}
		fi
	fi
	installed_count=0
	upgradable_count=0
	echo ""
	for candidate in ${candidates}; do
		upgradable="$(__kobman_determine_upgradable_version "$candidate")"
		case $? in
			1)
				$all || __kobman_echo_red "Not using any version of ${candidate}"
				;;
			2)
				echo ""
				__kobman_echo_red "Stop! Could not get remote version of ${candidate}"
				return 1
				;;
			*)
				if [ -n "$upgradable" ]; then
					[ ${upgradable_count} -eq 0 ] && __kobman_echo_no_colour "Upgrade:"
					__kobman_echo_no_colour "$upgradable"
					(( upgradable_count += 1 ))
					upgradable_candidates=(${upgradable_candidates[@]} $candidate)
				fi
				(( installed_count += 1 ))
				;;
		esac
	done
	if $all; then
		if [ ${installed_count} -eq 0 ]; then
			__kobman_echo_no_colour 'No candidates are in use'
		elif [ ${upgradable_count} -eq 0 ]; then
			__kobman_echo_no_colour "All candidates are up-to-date"
		fi
	elif [ ${upgradable_count} -eq 0 ]; then
		__kobman_echo_no_colour "${candidate} is up-to-date"
	fi
	if [ ${upgradable_count} -gt 0 ]; then
		echo ""
		__kobman_echo_confirm "Upgrade candidate(s) and set latest version(s) as default? (Y/n): "
		read UPGRADE_ALL
		export auto_answer_upgrade='true'
		if [[ -z "$UPGRADE_ALL" || "$UPGRADE_ALL" == "y" || "$UPGRADE_ALL" == "Y" ]]; then
			# Using array for bash & zsh compatibility
			for (( i=0; i <= ${#upgradable_candidates[*]}; i++ )); do
				upgradable_candidate="${upgradable_candidates[${i}]}"
				# Filter empty elements (in bash arrays are zero index based, in zsh they are 1 based)
				if [[ -n "$upgradable_candidate" ]]; then
					__kob_install $upgradable_candidate
				fi
			done
		fi
		unset auto_answer_upgrade
	fi
}

function __kobman_determine_upgradable_version {
	local candidate local_versions remote_default_version

	candidate="$1"

	# Resolve local versions
	local_versions="$(echo $(find "${KOBMAN_CANDIDATES_DIR}/${candidate}" -maxdepth 1 -mindepth 1 -type d -exec basename '{}' \; 2>/dev/null) | sed -e "s/ /, /g" )"
	if [ ${#local_versions} -eq 0 ]; then
		return 1
	fi

	# Resolve remote default version
	remote_default_version="$(__kobman_secure_curl "${KOBMAN_CANDIDATES_API}/candidates/default/${candidate}")"
	if [ -z "$remote_default_version" ]; then
		return 2
	fi

	# Check upgradable or not
	if [ ! -d "${KOBMAN_CANDIDATES_DIR}/${candidate}/${remote_default_version}" ]; then
		__kobman_echo_yellow "${candidate} (${local_versions} < ${remote_default_version})"
	fi
}
