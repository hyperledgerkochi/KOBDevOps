#!/usr/bin/env bash


function __kobman_path_contains {
	local candidate exists

	candidate="$1"
	exists="$(echo "$PATH" | grep "$candidate")"
	if [[ -n "$exists" ]]; then
		echo 'true'
	else
		echo 'false'
	fi
}

function __kobman_add_to_path {
	local candidate present

	candidate="$1"

	present=$(__kobman_path_contains "$candidate")
	if [[ "$present" == 'false' ]]; then
		PATH="$KOBMAN_CANDIDATES_DIR/$candidate/current/bin:$PATH"
	fi
}

function __kobman_set_candidate_home {
	local candidate version upper_candidate

	candidate="$1"
	version="$2"

	upper_candidate=$(echo "$candidate" | tr '[:lower:]' '[:upper:]')
	export "${upper_candidate}_HOME"="${KOBMAN_CANDIDATES_DIR}/${candidate}/${version}"
}

function __kobman_export_candidate_home {
	local candidate_name="$1"
	local candidate_dir="$2"
	local candidate_home_var="$(echo ${candidate_name} | tr '[:lower:]' '[:upper:]')_HOME"
	export $(echo "$candidate_home_var")="$candidate_dir"
}

function __kobman_determine_candidate_bin_dir {
	local candidate_dir="$1"
	if [[ -d "${candidate_dir}/bin" ]]; then
		echo "${candidate_dir}/bin"
	else
		echo "$candidate_dir"
	fi
}

function __kobman_prepend_candidate_to_path {
	local candidate_dir candidate_bin_dir

	candidate_dir="$1"
	candidate_bin_dir=$(__kobman_determine_candidate_bin_dir "$candidate_dir")
	echo "$PATH" | grep -q "$candidate_dir" || PATH="${candidate_bin_dir}:${PATH}"
	unset CANDIDATE_BIN_DIR
}

function __kobman_link_candidate_version {
	local candidate version

	candidate="$1"
	version="$2"

	# Change the 'current' symlink for the candidate, hence affecting all shells.
	if [[ -h "${KOBMAN_CANDIDATES_DIR}/${candidate}/current" || -d "${KOBMAN_CANDIDATES_DIR}/${candidate}/current" ]]; then
		rm -f "${KOBMAN_CANDIDATES_DIR}/${candidate}/current"
	fi
	ln -s "${KOBMAN_CANDIDATES_DIR}/${candidate}/${version}" "${KOBMAN_CANDIDATES_DIR}/${candidate}/current"
}
