#!/bin/bash
#
#

#Install: stable

# Global variables
# KOBPROJECT_SERVICE="https://api.KOBDevOps.io/2"




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
if [ -d "$KOB_SH" ]; then
	echo "KOBPROJECT found."
	echo ""
	echo "======================================================================================================"
	echo " You already have KOBPROJECT installed."
	echo " KOB Project  was found at:"
	echo ""
	echo "    ${KOB}"
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
echo "Install scripts..."
sudo git clone https://github.com/EtricKombat/KOBDevOps.git
sudo mv KOBDevOps/bin/sh KOBDevOps/bin/env /usr/bin

echo " available KOB_ENVs..."
export KOB_SH=/usr/bin/sh
export KOB_ENV=/usr/bin/env



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
echo ""
echo "    KOB help"
echo ""
echo "Enjoy!!!"
