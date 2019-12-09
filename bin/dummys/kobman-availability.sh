#!/usr/bin/env bash

#
#   Copyright 2017 Marco Vermeulen
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

function __kobman_update_broadcast_and_service_availability {
	local broadcast_live_id=$(__kobman_determine_broadcast_id)
	__kobman_set_availability "$broadcast_live_id"
	__kobman_update_broadcast "$broadcast_live_id"
}

function __kobman_determine_broadcast_id {
	if [[ "$KOBMAN_OFFLINE_MODE" == "true" || "$COMMAND" == "offline" && "$QUALIFIER" == "enable" ]]; then
		echo ""
	else
		echo $(__kobman_secure_curl_with_timeouts "${KOBMAN_CANDIDATES_API}/broadcast/latest/id")
	fi
}

function __kobman_set_availability {
	local broadcast_id="$1"
	local detect_html="$(echo "$broadcast_id" | tr '[:upper:]' '[:lower:]' | grep 'html')"
	if [[ -z "$broadcast_id" ]]; then
		KOBMAN_AVAILABLE="false"
		__kobman_display_offline_warning "$broadcast_id"
	elif [[ -n "$detect_html" ]]; then
		KOBMAN_AVAILABLE="false"
		__kobman_display_proxy_warning
	else
		KOBMAN_AVAILABLE="true"
	fi
}

function __kobman_display_offline_warning {
	local broadcast_id="$1"
	if [[ -z "$broadcast_id" && "$COMMAND" != "offline" && "$KOBMAN_OFFLINE_MODE" != "true" ]]; then
		__kobman_echo_red "==== INTERNET NOT REACHABLE! ==================================================="
		__kobman_echo_red ""
		__kobman_echo_red " Some functionality is disabled or only partially available."
		__kobman_echo_red " If this persists, please enable the offline mode:"
		__kobman_echo_red ""
		__kobman_echo_red "   $ kob offline"
		__kobman_echo_red ""
		__kobman_echo_red "================================================================================"
		echo ""
	fi
}

function __kobman_display_proxy_warning {
	__kobman_echo_red "==== PROXY DETECTED! ==========================================================="
	__kobman_echo_red "Please ensure you have open internet access to continue."
	__kobman_echo_red "================================================================================"
	echo ""
}

function __kobman_update_broadcast {
	local broadcast_live_id broadcast_id_file broadcast_text_file broadcast_old_id

	broadcast_live_id="$1"
	broadcast_id_file="${KOBMAN_DIR}/var/broadcast_id"
	broadcast_text_file="${KOBMAN_DIR}/var/broadcast"
	broadcast_old_id=""

	if [[ -f "$broadcast_id_file" ]]; then
		broadcast_old_id=$(cat "$broadcast_id_file");
	fi

	if [[ -f "$broadcast_text_file" ]]; then
		BROADCAST_OLD_TEXT=$(cat "$broadcast_text_file");
	fi

	if [[ "$KOBMAN_AVAILABLE" == "true" && "$broadcast_live_id" != "$broadcast_old_id" && "$COMMAND" != "selfupdate" && "$COMMAND" != "flush" ]]; then
		mkdir -p "${KOBMAN_DIR}/var"

		echo "$broadcast_live_id" | tee "$broadcast_id_file" > /dev/null

		BROADCAST_LIVE_TEXT=$(__kobman_secure_curl "${KOBMAN_CANDIDATES_API}/broadcast/latest")
		echo "$BROADCAST_LIVE_TEXT" | tee "$broadcast_text_file" > /dev/null
		if [[ "$COMMAND" != "broadcast" ]]; then
			__kobman_echo_cyan "$BROADCAST_LIVE_TEXT"
		fi
	fi
}
