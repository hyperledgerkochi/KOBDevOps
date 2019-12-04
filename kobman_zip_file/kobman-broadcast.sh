#!/usr/bin/env bash


function __kob_broadcast {
	if [ "$BROADCAST_OLD_TEXT" ]; then
		__kobman_echo_cyan "$BROADCAST_OLD_TEXT"
	else
		__kobman_echo_cyan "$BROADCAST_LIVE_TEXT"
	fi
}
