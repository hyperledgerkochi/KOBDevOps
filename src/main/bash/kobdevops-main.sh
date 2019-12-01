#!/usr/bin/env bash


function kob {

	COMMAND="$1"
	QUALIFIER="$2"

	case "$COMMAND" in
		l)
			COMMAND="list";;
		ls)
			COMMAND="list";;
		h)
			COMMAND="help";;
		v)
			COMMAND="version";;
		u)
			COMMAND="use";;
		i)
			COMMAND="install";;
		rm)
			COMMAND="uninstall";;
		c)
			COMMAND="current";;
		ug)
			COMMAND="upgrade";;
		d)
			COMMAND="default";;
		b)
			COMMAND="broadcast";;
	esac

	#
	# Various sanity checks and default settings
	#

	# Check version and candidates cache
	if [[ "$COMMAND" != "update" ]]; then
		___kobdevops_check_candidates_cache "$KOBDEVOPS_CANDIDATES_CACHE" || return 1
		___kobdevops_check_version_cache
	fi

	# Always presume internet availability
	KOBDEVOPS_AVAILABLE="true"
	if [ -z "$KOBDEVOPS_OFFLINE_MODE" ]; then
		KOBDEVOPS_OFFLINE_MODE="false"
	fi

	# ...unless proven otherwise
	__kobdevops_update_broadcast_and_service_availability

	# Load the kobdevops config if it exists.
	if [ -f "${KOBDEVOPS_DIR}/etc/config" ]; then
		source "${KOBDEVOPS_DIR}/etc/config"
	fi

	# no command provided
	if [[ -z "$COMMAND" ]]; then
		__kob_help
		return 1
	fi

	# Check if it is a valid command
	CMD_FOUND=""
	CMD_TARGET="${KOBDEVOPS_DIR}/src/kobdevops-${COMMAND}.sh"
	if [[ -f "$CMD_TARGET" ]]; then
		CMD_FOUND="$CMD_TARGET"
	fi

	# Check if it is a sourced function
	CMD_TARGET="${KOBDEVOPS_DIR}/ext/kobdevops-${COMMAND}.sh"
	if [[ -f "$CMD_TARGET" ]]; then
		CMD_FOUND="$CMD_TARGET"
	fi

	# couldn't find the command
	if [[ -z "$CMD_FOUND" ]]; then
		echo "Invalid command: $COMMAND"
		__kob_help
	fi

	# Check whether the candidate exists
	local kobdevops_valid_candidate=$(echo ${KOBDEVOPS_CANDIDATES[@]} | grep -w "$QUALIFIER")
	if [[ -n "$QUALIFIER" && "$COMMAND" != "offline" && "$COMMAND" != "flush" && "$COMMAND" != "selfupdate" && -z "$kobdevops_valid_candidate" ]]; then
		echo ""
		__kobdevops_echo_red "Stop! $QUALIFIER is not a valid candidate."
		return 1
	fi

	# Validate offline qualifier
	if [[ "$COMMAND" == "offline" && -n "$QUALIFIER" && -z $(echo "enable disable" | grep -w "$QUALIFIER") ]]; then
		echo ""
		__kobdevops_echo_red "Stop! $QUALIFIER is not a valid offline mode."
	fi

	# Check whether the command exists as an internal function...
	#
	# NOTE Internal commands use underscores rather than hyphens,
	# hence the name conversion as the first step here.
	CONVERTED_CMD_NAME=$(echo "$COMMAND" | tr '-' '_')

	# Store the return code of the requested command
	local final_rc=0

	# Execute the requested command
	if [ -n "$CMD_FOUND" ]; then
		# It's available as a shell function
		__kob_"$CONVERTED_CMD_NAME" "$QUALIFIER" "$3" "$4"
		final_rc=$?
	fi

	# Attempt upgrade after all is done
	if [[ "$COMMAND" != "selfupdate" ]]; then
		__kobdevops_auto_update "$KOBDEVOPS_REMOTE_VERSION" "$KOBDEVOPS_VERSION"
	fi
	return $final_rc
}
