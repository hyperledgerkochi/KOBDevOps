#!/usr/bin/env bash


function __kob_offline {
	local mode="$1"
	if [[ -z "$mode" || "$mode" == "enable" ]]; then
		KOBDEVOPS_OFFLINE_MODE="true"
		__kobdevops_echo_green "Offline mode enabled."
	fi
	if [[ "$mode" == "disable" ]]; then
		KOBDEVOPS_OFFLINE_MODE="false"
		__kobdevops_echo_green "Online mode re-enabled!"
	fi
}
