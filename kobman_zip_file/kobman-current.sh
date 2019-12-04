#!/usr/bin/env bash


function __kob_current {
	local candidate="$1"

	echo ""
	if [ -n "$candidate" ]; then
		__kobman_determine_current_version "$candidate"
		if [ -n "$CURRENT" ]; then
			__kobman_echo_no_colour "Using ${candidate} version ${CURRENT}"
		else
			__kobman_echo_red "Not using any version of ${candidate}"
		fi
	else
		local installed_count=0
		for (( i=0; i <= ${#KOBMAN_CANDIDATES[*]}; i++ )); do
			# Eliminate empty entries due to incompatibility
			if [[ -n ${KOBMAN_CANDIDATES[${i}]} ]]; then
				__kobman_determine_current_version "${KOBMAN_CANDIDATES[${i}]}"
				if [ -n "$CURRENT" ]; then
					if [ ${installed_count} -eq 0 ]; then
						__kobman_echo_no_colour 'Using:'
						echo ""
					fi
					__kobman_echo_no_colour "${KOBMAN_CANDIDATES[${i}]}: ${CURRENT}"
					(( installed_count += 1 ))
				fi
			fi
		done
		if [ ${installed_count} -eq 0 ]; then
			__kobman_echo_no_colour 'No candidates are in use'
		fi
	fi
}

function __kobman_determine_current_version {
	local candidate present

	candidate="$1"
	present=$(__kobman_path_contains "${KOBMAN_CANDIDATES_DIR}/${candidate}")
	if [[  "$present" == 'true' ]]; then
		if [[ "$solaris" == true ]]; then
			CURRENT=$(echo $PATH | gsed -r "s|${KOBMAN_CANDIDATES_DIR}/${candidate}/([^/]+)/bin|!!\1!!|1" | gsed -r "s|^.*!!(.+)!!.*$|\1|g")
		elif [[ "$darwin" == true ]]; then
			CURRENT=$(echo $PATH | sed -E "s|${KOBMAN_CANDIDATES_DIR}/${candidate}/([^/]+)/bin|!!\1!!|1" | sed -E "s|^.*!!(.+)!!.*$|\1|g")
		else
			CURRENT=$(echo $PATH | sed -r "s|${KOBMAN_CANDIDATES_DIR}/${candidate}/([^/]+)/bin|!!\1!!|1" | sed -r "s|^.*!!(.+)!!.*$|\1|g")
		fi

		if [[ "$CURRENT" == "current" ]]; then
			CURRENT=$(readlink "${KOBMAN_CANDIDATES_DIR}/${candidate}/current" | sed "s!${KOBMAN_CANDIDATES_DIR}/${candidate}/!!g")
		fi
	else
		CURRENT=""
	fi
}
