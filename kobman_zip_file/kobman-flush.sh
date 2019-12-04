#!/usr/bin/env bash


function __kob_flush {
	local qualifier="$1"

	case "$qualifier" in
		broadcast)
			if [[ -f "${KOBMAN_DIR}/var/broadcast_id" ]]; then
				rm "${KOBMAN_DIR}/var/broadcast_id"
				rm "${KOBMAN_DIR}/var/broadcast"
				__kobman_echo_green "Broadcast has been flushed."
			else
				__kobman_echo_no_colour "No prior broadcast found so not flushed."
			fi
			;;
		version)
			if [[ -f "${KOBMAN_DIR}/var/version" ]]; then
				rm "${KOBMAN_DIR}/var/version"
				__kobman_echo_green "Version file has been flushed."
			else
				__kobman_echo_no_colour "No prior Remote Version found so not flushed."
			fi
			;;
		archives)
			__kobman_cleanup_folder "archives"
			;;
		temp)
			__kobman_cleanup_folder "tmp"
			;;
		tmp)
			__kobman_cleanup_folder "tmp"
			;;
		*)
			__kobman_echo_red "Stop! Please specify what you want to flush."
			;;
	esac
}

function __kobman_cleanup_folder {
	local folder="$1"
	kobman_cleanup_dir="${KOBMAN_DIR}/${folder}"
	kobman_cleanup_disk_usage=$(du -sh "$kobman_cleanup_dir")
	kobman_cleanup_count=$(ls -1 "$kobman_cleanup_dir" | wc -l)

	rm -rf "${KOBMAN_DIR}/${folder}"
	mkdir "${KOBMAN_DIR}/${folder}"

	__kobman_echo_green "${kobman_cleanup_count} archive(s) flushed, freeing ${kobman_cleanup_disk_usage}."
}
