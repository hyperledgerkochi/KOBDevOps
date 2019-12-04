#!/usr/bin/env bash


function __kob_offline {
	local mode="$1"
	if [[ -z "$mode" || "$mode" == "enable" ]]; then
		KOBMAN_OFFLINE_MODE="true"
		__kobman_echo_green "Offline mode enabled."
	fi
	if [[ "$mode" == "disable" ]]; then
		KOBMAN_OFFLINE_MODE="false"
		__kobman_echo_green "Online mode re-enabled!"
	fi
}
