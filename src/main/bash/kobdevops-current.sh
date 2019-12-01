#!/usr/bin/env bash


function __kob_current {
	local candidate="$1"

	echo ""
	if [ -n "$candidate" ]; then
		__kobdevops_determine_current_version "$candidate"
		if [ -n "$CURRENT" ]; then
			__kobdevops_echo_no_colour "Using ${candidate} version ${CURRENT}"
		else
			__kobdevops_echo_red "Not using any version of ${candidate}"
		fi
	else
		local installed_count=0
		for (( i=0; i <= ${#KOBDEVOPS_CANDIDATES[*]}; i++ )); do
			# Eliminate empty entries due to incompatibility
			if [[ -n ${KOBDEVOPS_CANDIDATES[${i}]} ]]; then
				__kobdevops_determine_current_version "${KOBDEVOPS_CANDIDATES[${i}]}"
				if [ -n "$CURRENT" ]; then
					if [ ${installed_count} -eq 0 ]; then
						__kobdevops_echo_no_colour 'Using:'
						echo ""
					fi
					__kobdevops_echo_no_colour "${KOBDEVOPS_CANDIDATES[${i}]}: ${CURRENT}"
					(( installed_count += 1 ))
				fi
			fi
		done
		if [ ${installed_count} -eq 0 ]; then
			__kobdevops_echo_no_colour 'No candidates are in use'
		fi
	fi
}

function __kobdevops_determine_current_version {
	local candidate present

	candidate="$1"
	present=$(__kobdevops_path_contains "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}")
	if [[  "$present" == 'true' ]]; then
		if [[ "$solaris" == true ]]; then
			CURRENT=$(echo $PATH | gsed -r "s|${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/([^/]+)/bin|!!\1!!|1" | gsed -r "s|^.*!!(.+)!!.*$|\1|g")
		elif [[ "$darwin" == true ]]; then
			CURRENT=$(echo $PATH | sed -E "s|${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/([^/]+)/bin|!!\1!!|1" | sed -E "s|^.*!!(.+)!!.*$|\1|g")
		else
			CURRENT=$(echo $PATH | sed -r "s|${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/([^/]+)/bin|!!\1!!|1" | sed -r "s|^.*!!(.+)!!.*$|\1|g")
		fi

		if [[ "$CURRENT" == "current" ]]; then
			CURRENT=$(readlink "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/current" | sed "s!${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/!!g")
		fi
	else
		CURRENT=""
	fi
}
