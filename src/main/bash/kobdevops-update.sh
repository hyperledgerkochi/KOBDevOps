#!/usr/bin/env bash


function __kob_update {
	local candidates_uri="${KOBDEVOPS_CANDIDATES_API}/candidates/all"
	__kobdevops_echo_debug "Using candidates endpoint: $candidates_uri"

	local fresh_candidates_csv=$(__kobdevops_secure_curl_with_timeouts "$candidates_uri")
	local detect_html="$(echo "$fresh_candidates" | tr '[:upper:]' '[:lower:]' | grep 'html')"

	local fresh_candidates=("")
	local cached_candidates=("")

	if [[ "$zsh_shell" == 'true' ]]; then
		fresh_candidates=( ${(s:,:)fresh_candidates_csv} )
		cached_candidates=( ${(s:,:)KOBDEVOPS_CANDIDATES_CSV} )
	else
		OLD_IFS="$IFS"
		IFS=","
		fresh_candidates=(${fresh_candidates_csv})
		cached_candidates=(${KOBDEVOPS_CANDIDATES_CSV})
		IFS="$OLD_IFS"
	fi

	__kobdevops_echo_debug "Local candidates: $KOBDEVOPS_CANDIDATES_CSV"
	__kobdevops_echo_debug "Fetched candidates: $fresh_candidates_csv"

	if [[ -n "$fresh_candidates_csv" && -z "$detect_html" ]]; then

		# legacy bash workaround
		if [[ "$bash_shell" == 'true' && "$BASH_VERSINFO" -lt 4 ]]; then
			__kobdevops_legacy_bash_message
			echo "$fresh_candidates_csv" > "$KOBDEVOPS_CANDIDATES_CACHE"
			return 0
		fi

		local fresh_candidates_length=${#fresh_candidates_csv}
		local cached_candidates_length=${#KOBDEVOPS_CANDIDATES_CSV}
		__kobdevops_echo_debug "Fresh and cached candidate lengths: $fresh_candidates_length $cached_candidates_length"

		local diff_candidates=$(echo ${fresh_candidates[@]} ${cached_candidates[@]} | tr ' ' '\n' | sort | uniq -u | tr '\n' ' ')
		if (( fresh_candidates_length > cached_candidates_length )); then
			echo ""
			__kobdevops_echo_green "Adding new candidates(s): $diff_candidates"
			echo "$fresh_candidates_csv" > "$KOBDEVOPS_CANDIDATES_CACHE"
			echo ""
			__kobdevops_echo_yellow "Please open a new terminal now..."

		elif (( fresh_candidates_length < cached_candidates_length )); then
			echo ""
			__kobdevops_echo_green "Removing obsolete candidates(s): $diff_candidates"
			echo "$fresh_candidates_csv" > "$KOBDEVOPS_CANDIDATES_CACHE"
			echo ""
			__kobdevops_echo_yellow "Please open a new terminal now..."

		else
			touch "$KOBDEVOPS_CANDIDATES_CACHE"
			__kobdevops_echo_green "No new candidates found at this time."
		fi
	fi

}
