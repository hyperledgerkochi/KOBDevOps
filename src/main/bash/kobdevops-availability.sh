#!/usr/bin/env bash


function __kobdevops_update_broadcast_and_service_availability {
	local broadcast_live_id=$(__kobdevops_determine_broadcast_id)
	__kobdevops_set_availability "$broadcast_live_id"
	__kobdevops_update_broadcast "$broadcast_live_id"
}

function __kobdevops_determine_broadcast_id {
	if [[ "$KOBDEVOPS_OFFLINE_MODE" == "true" || "$COMMAND" == "offline" && "$QUALIFIER" == "enable" ]]; then
		echo ""
	else
		echo $(__kobdevops_secure_curl_with_timeouts "${KOBDEVOPS_CANDIDATES_API}/broadcast/latest/id")
	fi
}

function __kobdevops_set_availability {
	local broadcast_id="$1"
	local detect_html="$(echo "$broadcast_id" | tr '[:upper:]' '[:lower:]' | grep 'html')"
	if [[ -z "$broadcast_id" ]]; then
		KOBDEVOPS_AVAILABLE="false"
		__kobdevops_display_offline_warning "$broadcast_id"
	elif [[ -n "$detect_html" ]]; then
		KOBDEVOPS_AVAILABLE="false"
		__kobdevops_display_proxy_warning
	else
		KOBDEVOPS_AVAILABLE="true"
	fi
}

function __kobdevops_display_offline_warning {
	local broadcast_id="$1"
	if [[ -z "$broadcast_id" && "$COMMAND" != "offline" && "$KOBDEVOPS_OFFLINE_MODE" != "true" ]]; then
		__kobdevops_echo_red "==== INTERNET NOT REACHABLE! ==================================================="
		__kobdevops_echo_red ""
		__kobdevops_echo_red " Some functionality is disabled or only partially available."
		__kobdevops_echo_red " If this persists, please enable the offline mode:"
		__kobdevops_echo_red ""
		__kobdevops_echo_red "   $ kob offline"
		__kobdevops_echo_red ""
		__kobdevops_echo_red "================================================================================"
		echo ""
	fi
}

function __kobdevops_display_proxy_warning {
	__kobdevops_echo_red "==== PROXY DETECTED! ==========================================================="
	__kobdevops_echo_red "Please ensure you have open internet access to continue."
	__kobdevops_echo_red "================================================================================"
	echo ""
}

function __kobdevops_update_broadcast {
	local broadcast_live_id broadcast_id_file broadcast_text_file broadcast_old_id

	broadcast_live_id="$1"
	broadcast_id_file="${KOBDEVOPS_DIR}/var/broadcast_id"
	broadcast_text_file="${KOBDEVOPS_DIR}/var/broadcast"
	broadcast_old_id=""

	if [[ -f "$broadcast_id_file" ]]; then
		broadcast_old_id=$(cat "$broadcast_id_file");
	fi

	if [[ -f "$broadcast_text_file" ]]; then
		BROADCAST_OLD_TEXT=$(cat "$broadcast_text_file");
	fi

	if [[ "$KOBDEVOPS_AVAILABLE" == "true" && "$broadcast_live_id" != "$broadcast_old_id" && "$COMMAND" != "selfupdate" && "$COMMAND" != "flush" ]]; then
		mkdir -p "${KOBDEVOPS_DIR}/var"

		echo "$broadcast_live_id" | tee "$broadcast_id_file" > /dev/null

		BROADCAST_LIVE_TEXT=$(__kobdevops_secure_curl "${KOBDEVOPS_CANDIDATES_API}/broadcast/latest")
		echo "$BROADCAST_LIVE_TEXT" | tee "$broadcast_text_file" > /dev/null
		if [[ "$COMMAND" != "broadcast" ]]; then
			__kobdevops_echo_cyan "$BROADCAST_LIVE_TEXT"
		fi
	fi
}
