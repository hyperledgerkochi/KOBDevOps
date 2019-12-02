#!/usr/bin/env bash


function __kobdevops_path_contains {
	local candidate exists

	candidate="$1"
	exists="$(echo "$PATH" | grep "$candidate")"
	if [[ -n "$exists" ]]; then
		echo 'true'
	else
		echo 'false'
	fi
}

function __kobdevops_add_to_path {
	local candidate present

	candidate="$1"

	present=$(__kobdevops_path_contains "$candidate")
	if [[ "$present" == 'false' ]]; then
		PATH="$KOBDEVOPS_CANDIDATES_DIR/$candidate/current/bin:$PATH"
	fi
}

function __kobdevops_set_candidate_home {
	local candidate version upper_candidate

	candidate="$1"
	version="$2"

	upper_candidate=$(echo "$candidate" | tr '[:lower:]' '[:upper:]')
	export "${upper_candidate}_HOME"="${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/${version}"
}

function __kobdevops_export_candidate_home {
	local candidate_name="$1"
	local candidate_dir="$2"
	local candidate_home_var="$(echo ${candidate_name} | tr '[:lower:]' '[:upper:]')_HOME"
	export $(echo "$candidate_home_var")="$candidate_dir"
}

function __kobdevops_determine_candidate_bin_dir {
	local candidate_dir="$1"
	if [[ -d "${candidate_dir}/bin" ]]; then
		echo "${candidate_dir}/bin"
	else
		echo "$candidate_dir"
	fi
}

function __kobdevops_prepend_candidate_to_path {
	local candidate_dir candidate_bin_dir

	candidate_dir="$1"
	candidate_bin_dir=$(__kobdevops_determine_candidate_bin_dir "$candidate_dir")
	echo "$PATH" | grep -q "$candidate_dir" || PATH="${candidate_bin_dir}:${PATH}"
	unset CANDIDATE_BIN_DIR
}

function __kobdevops_link_candidate_version {
	local candidate version

	candidate="$1"
	version="$2"

	# Change the 'current' symlink for the candidate, hence affecting all shells.
	if [[ -h "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/current" || -d "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/current" ]]; then
		rm -f "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/current"
	fi
	ln -s "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/${version}" "${KOBDEVOPS_CANDIDATES_DIR}/${candidate}/current"
}
