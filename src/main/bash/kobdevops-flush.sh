#!/usr/bin/env bash


function __kob_flush {
	local qualifier="$1"

	case "$qualifier" in
		broadcast)
			if [[ -f "${KOBDEVOPS_DIR}/var/broadcast_id" ]]; then
				rm "${KOBDEVOPS_DIR}/var/broadcast_id"
				rm "${KOBDEVOPS_DIR}/var/broadcast"
				__kobdevops_echo_green "Broadcast has been flushed."
			else
				__kobdevops_echo_no_colour "No prior broadcast found so not flushed."
			fi
			;;
		version)
			if [[ -f "${KOBDEVOPS_DIR}/var/version" ]]; then
				rm "${KOBDEVOPS_DIR}/var/version"
				__kobdevops_echo_green "Version file has been flushed."
			fi
			;;
		archives)
			__kobdevops_cleanup_folder "archives"
			;;
		temp)
			__kobdevops_cleanup_folder "tmp"
			;;
		tmp)
			__kobdevops_cleanup_folder "tmp"
			;;
		*)
			__kobdevops_echo_red "Stop! Please specify what you want to flush."
			;;
	esac
}

function __kobdevops_cleanup_folder {
	local folder="$1"
	kobdevops_cleanup_dir="${KOBDEVOPS_DIR}/${folder}"
	kobdevops_cleanup_disk_usage=$(du -sh "$kobdevops_cleanup_dir")
	kobdevops_cleanup_count=$(ls -1 "$kobdevops_cleanup_dir" | wc -l)

	rm -rf "${KOBDEVOPS_DIR}/${folder}"
	mkdir "${KOBDEVOPS_DIR}/${folder}"

	__kobdevops_echo_green "${kobdevops_cleanup_count} archive(s) flushed, freeing ${kobdevops_cleanup_disk_usage}."
}
