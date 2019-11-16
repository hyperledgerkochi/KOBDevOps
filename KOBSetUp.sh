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
# KOBPROJECT_SERVICE="https://api.KOBDevOps.io/2"
KOBPROJECT_VERSION="5.7.4+362"
KOBPROJECT_PLATFORM=$(uname)

if [ -z "$KOBPROJECT_DIR" ]; then
    KOBPROJECT_DIR="$HOME/.KOBDevOps"
fi

# Local variables
kobproject_bin_folder="${KOBPROJECT_DIR}/bin"
kobproject_src_folder="${KOBPROJECT_DIR}/src"
kobproject_tmp_folder="${KOBPROJECT_DIR}/tmp"
kobproject_stage_folder="${kobproject_tmp_folder}/stage"
kobproject_zip_file="${kobproject_tmp_folder}/KOBDevOps-${KOBPROJECT_VERSION}.zip"
kobproject_ext_folder="${KOBPROJECT_DIR}/ext"
kobproject_etc_folder="${KOBPROJECT_DIR}/etc"
kobproject_var_folder="${KOBPROJECT_DIR}/var"
kobproject_archives_folder="${KOBPROJECT_DIR}/archives"
kobproject_KOB_ENVs_folder="${KOBPROJECT_DIR}/KOB_ENVs"
kobproject_config_file="${kobproject_etc_folder}/config"
kobproject_bash_profile="${HOME}/.bash_profile"
kobproject_profile="${HOME}/.profile"
kobproject_bashrc="${HOME}/.bashrc"
kobproject_zshrc="${HOME}/.zshrc"

kobproject_init_snippet=$( cat << EOF
#THIS MUST BE AT THE END OF THE FILE FOR KOBPROJECT TO WORK!!!
export KOBPROJECT_DIR="$KOBPROJECT_DIR"
[[ -s "${KOBPROJECT_DIR}/bin/KOBDevOps-init.sh" ]] && source "${KOBPROJECT_DIR}/bin/KOBDevOps-init.sh"
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
mkdir -p "$kobproject_bin_folder"
mkdir -p "$kobproject_src_folder"
mkdir -p "$kobproject_tmp_folder"
mkdir -p "$kobproject_stage_folder"
mkdir -p "$kobproject_ext_folder"
mkdir -p "$kobproject_etc_folder"
mkdir -p "$kobproject_var_folder"
mkdir -p "$kobproject_archives_folder"
mkdir -p "$kobproject_KOB_ENVs_folder"

echo "Getting available KOB_ENVs..."
KOBPROJECT_CANDIDATES_CSV=$(curl -s "${KOBPROJECT_SERVICE}/KOB_ENVs/all")
echo "$KOBPROJECT_CANDIDATES_CSV" > "${KOBPROJECT_DIR}/var/KOB_ENVs"

echo "Prime the config file..."
touch "$kobproject_config_file"
echo "kobproject_auto_answer=false" >> "$kobproject_config_file"
echo "kobproject_auto_selfupdate=false" >> "$kobproject_config_file"
echo "kobproject_insecure_ssl=false" >> "$kobproject_config_file"
echo "kobproject_curl_connect_timeout=7" >> "$kobproject_config_file"
echo "kobproject_curl_max_time=10" >> "$kobproject_config_file"
echo "kobproject_beta_channel=false" >> "$kobproject_config_file"
echo "kobproject_debug_mode=false" >> "$kobproject_config_file"
echo "kobproject_colour_enable=true" >> "$kobproject_config_file"

echo "Download script archive..."
curl --location --progress-bar "${KOBPROJECT_SERVICE}/broker/download/KOBDevOps/install/${KOBPROJECT_VERSION}/${KOBPROJECT_PLATFORM}" > "$kobproject_zip_file"

ARCHIVE_OK=$(unzip -qt "$kobproject_zip_file" | grep 'No errors detected in compressed data')
if [[ -z "$ARCHIVE_OK" ]]; then
	echo "Downloaded zip archive corrupt. Are you connected to the internet?"
	echo ""
	echo "If problems persist, please ask for help on our Slack:"
	echo "* easy sign up: https://slack.KOBDevOps.io/"
	echo "* report on channel: https://KOBDevOps.slack.com/app_redirect?channel=user-issues"
	rm -rf "$KOBPROJECT_DIR"
	exit 2
fi

echo "Extract script archive..."
if [[ "$cygwin" == 'true' ]]; then
	echo "Cygwin detected - normalizing paths for unzip..."
	kobproject_zip_file=$(cygpath -w "$kobproject_zip_file")
	kobproject_stage_folder=$(cygpath -w "$kobproject_stage_folder")
fi
unzip -qo "$kobproject_zip_file" -d "$kobproject_stage_folder"


echo "Install scripts..."
mv "${kobproject_stage_folder}/KOBDevOps-init.sh" "$kobproject_bin_folder"
mv "$kobproject_stage_folder"/KOBDevOps-* "$kobproject_src_folder"

echo "Set version to $KOBPROJECT_VERSION ..."
echo "$KOBPROJECT_VERSION" > "${KOBPROJECT_DIR}/var/version"


if [[ $darwin == true ]]; then
  touch "$kobproject_bash_profile"
  echo "Attempt update of login bash profile on OSX..."
  if [[ -z $(grep 'KOBDevOps-init.sh' "$kobproject_bash_profile") ]]; then
    echo -e "\n$kobproject_init_snippet" >> "$kobproject_bash_profile"
    echo "Added KOBDevOps init snippet to $kobproject_bash_profile"
  fi
else
  echo "Attempt update of interactive bash profile on regular UNIX..."
  touch "${kobproject_bashrc}"
  if [[ -z $(grep 'KOBDevOps-init.sh' "$kobproject_bashrc") ]]; then
      echo -e "\n$kobproject_init_snippet" >> "$kobproject_bashrc"
      echo "Added KOBDevOps init snippet to $kobproject_bashrc"
  fi
fi

echo "Attempt update of zsh profile..."
touch "$kobproject_zshrc"
if [[ -z $(grep 'KOBDevOps-init.sh' "$kobproject_zshrc") ]]; then
    echo -e "\n$kobproject_init_snippet" >> "$kobproject_zshrc"
    echo "Updated existing ${kobproject_zshrc}"
fi

echo -e "\n\n\nAll done!\n\n"

echo "Please open a new terminal, or run the following in the existing one:"
echo ""
echo "    source \"${KOBPROJECT_DIR}/bin/KOBDevOps-init.sh\""
echo ""
echo "Then issue the following command:"
echo ""
echo "    kob help"
echo ""
echo "Enjoy!!!"
