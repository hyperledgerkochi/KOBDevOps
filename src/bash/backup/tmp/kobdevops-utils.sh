#!/usr/bin/env bash


function __kobdevops_echo_debug {
	if [[ "$kobdevops_debug_mode" == 'true' ]]; then
		echo "$1"
	fi
}

function __kobdevops_secure_curl {
	if [[ "${kobdevops_insecure_ssl}" == 'true' ]]; then
		curl --insecure --silent --location "$1"
	else
		curl --silent --location "$1"
	fi
}

function __kobdevops_secure_curl_download {
	local curl_params="--progress-bar --location"
	if [[ "${kobdevops_insecure_ssl}" == 'true' ]]; then
		curl_params="$curl_params --insecure"
	fi

	if [[ ! -z "${kobdevops_curl_retry}" ]]; then
		curl_params="--retry ${kobdevops_curl_retry} ${curl_params}"
	fi

	if [[ ! -z "${kobdevops_curl_retry_max_time}" ]]; then
		curl_params="--retry-max-time ${kobdevops_curl_retry_max_time} ${curl_params}"
	fi

	if [[ "${kobdevops_curl_continue}" == 'true' ]]; then
		curl_params="-C - ${curl_params}"
	fi

	if [[ "${kobdevops_debug_mode}" == 'true' ]]; then
		curl_params="--verbose ${curl_params}"
	fi

	if [[ "$zsh_shell" == 'true' ]]; then
		curl ${=curl_params} "$@"
	else
		curl ${curl_params} "$@"
	fi
}

function __kobdevops_secure_curl_with_timeouts {
	if [[ "${kobdevops_insecure_ssl}" == 'true' ]]; then
		curl --insecure --silent --location --connect-timeout ${kobdevops_curl_connect_timeout} --max-time ${kobdevops_curl_max_time} "$1"
	else
		curl --silent --location --connect-timeout ${kobdevops_curl_connect_timeout} --max-time ${kobdevops_curl_max_time} "$1"
	fi
}

function __kobdevops_page {
	if [[ -n "$PAGER" ]]; then
		"$@" | eval $PAGER
	elif command -v less >& /dev/null; then
		"$@" | less
	else
		"$@"
	fi
}

function __kobdevops_echo {
	if [[ "$kobdevops_colour_enable" == 'false' ]]; then
		echo -e "$2"
	else
		echo -e "\033[1;$1$2\033[0m"
	fi
}

function __kobdevops_echo_red {
	__kobdevops_echo "31m" "$1"
}

function __kobdevops_echo_no_colour {
	echo "$1"
}

function __kobdevops_echo_yellow {
	__kobdevops_echo "33m" "$1"
}

function __kobdevops_echo_green {
	__kobdevops_echo "32m" "$1"
}

function __kobdevops_echo_cyan {
	__kobdevops_echo "36m" "$1"
}

function __kobdevops_echo_confirm {
	if [[ "$kobdevops_colour_enable" == 'false' ]]; then
		echo -n "$1"
	else
		echo -e -n "\033[1;33m$1\033[0m"
	fi
}

function __kobdevops_legacy_bash_message {
	__kobdevops_echo_red "An outdated version of bash was detected on your system!"
	echo ""
	__kobdevops_echo_red "We recommend upgrading to bash 4.x, you have:"
	echo ""
	__kobdevops_echo_yellow "  $BASH_VERSION"
	echo ""
	__kobdevops_echo_yellow "Need to use brute force to replace candidates..."
}
