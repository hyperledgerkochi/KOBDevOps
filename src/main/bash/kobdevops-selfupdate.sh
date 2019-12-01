#!/usr/bin/env bash


function __kob_selfupdate {
	local force_selfupdate

	force_selfupdate="$1"
	if [[ "$KOBDEVOPS_AVAILABLE" == "false" ]]; then
		echo "This command is not available while offline."

	elif [[ "$KOBDEVOPS_REMOTE_VERSION" == "$KOBDEVOPS_VERSION" && "$force_selfupdate" != "force" ]]; then
		echo "No update available at this time."

	else
		export kobdevops_debug_mode
		export kobdevops_beta_channel
		__kobdevops_secure_curl "${KOBDEVOPS_CANDIDATES_API}/selfupdate?beta=${kobdevops_beta_channel}" | bash
	fi
	unset KOBDEVOPS_FORCE_SELFUPDATE
}

function __kobdevops_auto_update {
	local remote_version version delay_upgrade

	remote_version="$1"
	version="$2"
	delay_upgrade="${KOBDEVOPS_DIR}/var/delay_upgrade"

	if [[ -n "$(find "$delay_upgrade" -mtime +1)" && "$remote_version" != "$version" ]]; then
		echo ""
		echo ""
		__kobdevops_echo_yellow "ATTENTION: A new version of KOBDEVOPS is available..."
		echo ""
		__kobdevops_echo_no_colour "The current version is $remote_version, but you have $version."
		echo ""

		if [[ "$kobdevops_auto_selfupdate" != "true" ]]; then
			__kobdevops_echo_confirm "Would you like to upgrade now? (Y/n): "
			read upgrade
		fi

		if [[ -z "$upgrade" ]]; then upgrade="Y"; fi

		if [[ "$upgrade" == "Y" || "$upgrade" == "y" ]]; then
			__kob_selfupdate
			unset upgrade
		else
			__kobdevops_echo_no_colour "Not upgrading today..."
		fi

		touch "$delay_upgrade"
	fi

}
