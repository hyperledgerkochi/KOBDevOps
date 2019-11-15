#!/bin/bash
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

#Install: stable

# Global variables
KOBPROJECT_SERVICE="https://api.kobman.io/2"
KOBPROJECT_VERSION="5.7.4+362"
KOBPROJECT_PLATFORM=$(uname)

if [ -z "$KOBPROJECT_DIR" ]; then
    KOBPROJECT_DIR="$HOME/.kobman"
fi

# Local variables
kobman_bin_folder="${KOBPROJECT_DIR}/bin"
kobman_src_folder="${KOBPROJECT_DIR}/src"
kobman_tmp_folder="${KOBPROJECT_DIR}/tmp"
kobman_stage_folder="${kobman_tmp_folder}/stage"
kobman_zip_file="${kobman_tmp_folder}/kobman-${KOBPROJECT_VERSION}.zip"
kobman_ext_folder="${KOBPROJECT_DIR}/ext"
kobman_etc_folder="${KOBPROJECT_DIR}/etc"
kobman_var_folder="${KOBPROJECT_DIR}/var"
kobman_archives_folder="${KOBPROJECT_DIR}/archives"
kobman_candidates_folder="${KOBPROJECT_DIR}/candidates"
kobman_config_file="${kobman_etc_folder}/config"
kobman_bash_profile="${HOME}/.bash_profile"
kobman_profile="${HOME}/.profile"
kobman_bashrc="${HOME}/.bashrc"
kobman_zshrc="${HOME}/.zshrc"

kobman_init_snippet=$( cat << EOF
#THIS MUST BE AT THE END OF THE FILE FOR KOBPROJECT TO WORK!!!
export KOBPROJECT_DIR="$KOBPROJECT_DIR"
[[ -s "${KOBPROJECT_DIR}/bin/kobman-init.sh" ]] && source "${KOBPROJECT_DIR}/bin/kobman-init.sh"
EOF
)

# OS specific support (must be 'true' or 'false').
cygwin=false;
darwin=false;
solaris=false;
freebsd=false;
case "$(uname)" in
    CYGWIN*)
        cygwin=true
        ;;
    Darwin*)
        darwin=true
        ;;
    SunOS*)
        solaris=true
        ;;
    FreeBSD*)
        freebsd=true
esac





echo " __    __                      __        __                                "
echo " /  |  /  |                    /  |      /  |                              "
echo " $$ | /$$/   ______    _______ $$ |____  $$/                               "
echo " $$ |/$$/   /      \  /       |$$      \ /  |                              "
echo " $$  $$<   /$$$$$$  |/$$$$$$$/ $$$$$$$  |$$ |                              "
echo " $$$$$  \  $$ |  $$ |$$ |      $$ |  $$ |$$ |                              "
echo " $$ |$$  \ $$ \__$$ |$$ \_____ $$ |  $$ |$$ |                              "
echo " $$ | $$  |$$    $$/ $$       |$$ |  $$ |$$ |                              "
echo " $$/   $$/  $$$$$$/   $$$$$$$/ $$/   $$/ $$/                               "
echo "   ______                      _______                       __            "
echo "  /      \                    /       \                     /  |           "
echo " /$$$$$$  |  ______   ______  $$$$$$$  |  ______    ______  $$ |   __      "
echo " $$ |  $$ | /      \ /      \ $$ |__$$ | /      \  /      \ $$ |  /  |     "
echo " $$ |  $$ |/$$$$$$  /$$$$$$  |$$    $$< /$$$$$$  |/$$$$$$  |$$ |_/$$/      "
echo " $$ |  $$ |$$ |  $$/$$ |  $$ |$$$$$$$  |$$ |  $$ |$$ |  $$ |$$   $$<       "
echo " $$ \__$$ |$$ |     $$ \__$$ |$$ |__$$ |$$ \__$$ |$$ \__$$ |$$$$$$  \      "
echo " $$    $$/ $$ |     $$    $$ |$$    $$/ $$    $$/ $$    $$/ $$ | $$  |     "
echo "  $$$$$$/  $$/       $$$$$$$ |$$$$$$$/   $$$$$$/   $$$$$$/  $$/   $$/      "
echo "                    /  \__$$ |                                             "
echo "                    $$    $$/                                              "
echo "                     $$$$$$/                                               "








# Sanity checks

echo "Looking for a previous installation of KOBPROJECT..."
if [ -d "$KOBPROJECT_DIR" ]; then
	echo "KOBPROJECT found."
	echo ""
	echo "======================================================================================================"
	echo " You already have KOBPROJECT installed."
	echo " KOBPROJECT was found at:"
	echo ""
	echo "    ${KOBPROJECT_DIR}"
	echo ""
	echo " Please consider running the following if you need to upgrade."
	echo ""
	echo "    $ kob selfupdate force"
	echo ""
	echo "======================================================================================================"
	echo ""
	exit 0
fi

echo "Looking for unzip..."
if [ -z $(which unzip) ]; then
	echo "Not found."
	echo "======================================================================================================"
	echo " Please install unzip on your system using your favourite package manager."
	echo ""
	echo " Restart after installing unzip."
	echo "======================================================================================================"
	echo ""
	exit 1
fi

echo "Looking for zip..."
if [ -z $(which zip) ]; then
	echo "Not found."
	echo "======================================================================================================"
	echo " Please install zip on your system using your favourite package manager."
	echo ""
	echo " Restart after installing zip."
	echo "======================================================================================================"
	echo ""
	exit 1
fi

echo "Looking for curl..."
if [ -z $(which curl) ]; then
	echo "Not found."
	echo ""
	echo "======================================================================================================"
	echo " Please install curl on your system using your favourite package manager."
	echo ""
	echo " Restart after installing curl."
	echo "======================================================================================================"
	echo ""
	exit 1
fi

if [[ "$solaris" == true ]]; then
	echo "Looking for gsed..."
	if [ -z $(which gsed) ]; then
		echo "Not found."
		echo ""
		echo "======================================================================================================"
		echo " Please install gsed on your solaris system."
		echo ""
		echo " KOBPROJECT uses gsed extensively."
		echo ""
		echo " Restart after installing gsed."
		echo "======================================================================================================"
		echo ""
		exit 1
	fi
else
	echo "Looking for sed..."
	if [ -z $(which sed) ]; then
		echo "Not found."
		echo ""
		echo "======================================================================================================"
		echo " Please install sed on your system using your favourite package manager."
		echo ""
		echo " Restart after installing sed."
		echo "======================================================================================================"
		echo ""
		exit 1
	fi
fi


echo "Installing KOBPROJECT scripts..."


# Create directory structure

echo "Create distribution directories..."
mkdir -p "$kobman_bin_folder"
mkdir -p "$kobman_src_folder"
mkdir -p "$kobman_tmp_folder"
mkdir -p "$kobman_stage_folder"
mkdir -p "$kobman_ext_folder"
mkdir -p "$kobman_etc_folder"
mkdir -p "$kobman_var_folder"
mkdir -p "$kobman_archives_folder"
mkdir -p "$kobman_candidates_folder"

echo "Getting available candidates..."
KOBPROJECT_CANDIDATES_CSV=$(curl -s "${KOBPROJECT_SERVICE}/candidates/all")
echo "$KOBPROJECT_CANDIDATES_CSV" > "${KOBPROJECT_DIR}/var/candidates"

echo "Prime the config file..."
touch "$kobman_config_file"
echo "kobman_auto_answer=false" >> "$kobman_config_file"
echo "kobman_auto_selfupdate=false" >> "$kobman_config_file"
echo "kobman_insecure_ssl=false" >> "$kobman_config_file"
echo "kobman_curl_connect_timeout=7" >> "$kobman_config_file"
echo "kobman_curl_max_time=10" >> "$kobman_config_file"
echo "kobman_beta_channel=false" >> "$kobman_config_file"
echo "kobman_debug_mode=false" >> "$kobman_config_file"
echo "kobman_colour_enable=true" >> "$kobman_config_file"

echo "Download script archive..."
curl --location --progress-bar "${KOBPROJECT_SERVICE}/broker/download/kobman/install/${KOBPROJECT_VERSION}/${KOBPROJECT_PLATFORM}" > "$kobman_zip_file"

ARCHIVE_OK=$(unzip -qt "$kobman_zip_file" | grep 'No errors detected in compressed data')
if [[ -z "$ARCHIVE_OK" ]]; then
	echo "Downloaded zip archive corrupt. Are you connected to the internet?"
	echo ""
	echo "If problems persist, please ask for help on our Slack:"
	echo "* easy sign up: https://slack.kobman.io/"
	echo "* report on channel: https://kobman.slack.com/app_redirect?channel=user-issues"
	rm -rf "$KOBPROJECT_DIR"
	exit 2
fi

echo "Extract script archive..."
if [[ "$cygwin" == 'true' ]]; then
	echo "Cygwin detected - normalizing paths for unzip..."
	kobman_zip_file=$(cygpath -w "$kobman_zip_file")
	kobman_stage_folder=$(cygpath -w "$kobman_stage_folder")
fi
unzip -qo "$kobman_zip_file" -d "$kobman_stage_folder"


echo "Install scripts..."
mv "${kobman_stage_folder}/kobman-init.sh" "$kobman_bin_folder"
mv "$kobman_stage_folder"/kobman-* "$kobman_src_folder"

echo "Set version to $KOBPROJECT_VERSION ..."
echo "$KOBPROJECT_VERSION" > "${KOBPROJECT_DIR}/var/version"


if [[ $darwin == true ]]; then
  touch "$kobman_bash_profile"
  echo "Attempt update of login bash profile on OSX..."
  if [[ -z $(grep 'kobman-init.sh' "$kobman_bash_profile") ]]; then
    echo -e "\n$kobman_init_snippet" >> "$kobman_bash_profile"
    echo "Added kobman init snippet to $kobman_bash_profile"
  fi
else
  echo "Attempt update of interactive bash profile on regular UNIX..."
  touch "${kobman_bashrc}"
  if [[ -z $(grep 'kobman-init.sh' "$kobman_bashrc") ]]; then
      echo -e "\n$kobman_init_snippet" >> "$kobman_bashrc"
      echo "Added kobman init snippet to $kobman_bashrc"
  fi
fi

echo "Attempt update of zsh profile..."
touch "$kobman_zshrc"
if [[ -z $(grep 'kobman-init.sh' "$kobman_zshrc") ]]; then
    echo -e "\n$kobman_init_snippet" >> "$kobman_zshrc"
    echo "Updated existing ${kobman_zshrc}"
fi

echo -e "\n\n\nAll done!\n\n"

echo "Please open a new terminal, or run the following in the existing one:"
echo ""
echo "    source \"${KOBPROJECT_DIR}/bin/kobman-init.sh\""
echo ""
echo "Then issue the following command:"
echo ""
echo "    kob help"
echo ""
echo "Enjoy!!!"
