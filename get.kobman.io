
#!/bin/bash

#Install: stable

# Global variables
KOBMAN_VERSION="5.7.4+362"
KOBMAN_PLATFORM=$(uname)
KOBMAN_SERVICE="https://raw.githubusercontent.com"
# KOBMAN_NAMESPACE="EtricKombat"



if [ -z "$KOBMAN_DIR" ]; then
    KOBMAN_DIR="$HOME/.kobman"
fi

# Local variables
kobman_bin_folder="${KOBMAN_DIR}/bin"
kobman_src_folder="${KOBMAN_DIR}/src"
kobman_tmp_folder="${KOBMAN_DIR}/tmp"
kobman_stage_folder="${kobman_tmp_folder}/stage"
kobman_zip_file="${kobman_tmp_folder}/kobman-${KOBMAN_VERSION}.zip"
kobman_env_folder="${KOBMAN_DIR}/env"
kobman_etc_folder="${KOBMAN_DIR}/etc"
kobman_var_folder="${KOBMAN_DIR}/var"
kobman_archives_folder="${KOBMAN_DIR}/archives"
kobman_candidates_folder="${KOBMAN_DIR}/candidates"
kobman_config_file="${kobman_etc_folder}/config"
kobman_bash_profile="${HOME}/.bash_profile"
kobman_profile="${HOME}/.profile"
kobman_bashrc="${HOME}/.bashrc"
kobman_zshrc="${HOME}/.zshrc"

kobman_init_snippet=$( cat << EOF
#THIS MUST BE AT THE END OF THE FILE FOR KOBMAN TO WORK!!!
export KOBMAN_DIR="$KOBMAN_DIR"
[[ -s "${KOBMAN_DIR}/bin/kobman-init.sh" ]] && source "${KOBMAN_DIR}/bin/kobman-init.sh"
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

sudo apt install figlet -y

figlet KOB-Setup ...
figlet TrinityGroup repo 

# Sanity checks

echo "Looking for a previous installation of KOBMAN..."
if [ -d "$KOBMAN_DIR" ]; then
	echo "KOBMAN found."
	echo ""
	echo "======================================================================================================"
	echo " You already have KOBMAN installed."
	echo " KOBMAN was found at:"
	echo ""
	echo "    ${KOBMAN_DIR}"
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
		echo " KOBMAN uses gsed extensively."
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


echo "Installing KOBMAN scripts..."


# Create directory structure

echo "Create distribution directories..."
mkdir -p "$kobman_bin_folder"
mkdir -p "$kobman_src_folder"
mkdir -p "$kobman_tmp_folder"
mkdir -p "$kobman_stage_folder"
mkdir -p "$kobman_env_folder"
mkdir -p "$kobman_etc_folder"
mkdir -p "$kobman_var_folder"
mkdir -p "$kobman_archives_folder"
mkdir -p "$kobman_candidates_folder"

echo "Getting available candidates..."
KOBMAN_CANDIDATES_CSV=$(curl -s "${KOBMAN_SERVICE}/TrinityGroup/KOBDevOps/master/all")
echo "$KOBMAN_CANDIDATES_CSV" > "${KOBMAN_DIR}/var/candidates"

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

curl --location --progress-bar "${KOBMAN_SERVICE}/TrinityGroup/KOBDevOps/master/kobman_zip_file.zip" > "$kobman_zip_file"

ARCHIVE_OK=$(unzip -qt "$kobman_zip_file" | grep 'No errors detected in compressed data')
if [[ -z "$ARCHIVE_OK" ]]; then
	echo "Downloaded zip archive corrupt. Are you connected to the internet?"
	echo ""
	echo "If problems persist, please ask for help on our Github:"
	echo "* easy sign up: https://github.com/"
	echo "https://github.com/TrinityGroup/KOBDevOps/issues"
	rm -rf "$KOBMAN_DIR"
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
mv "$kobman_stage_folder"/kobman-kob* "$kobman_env_folder"
mv "$kobman_stage_folder"/kobman-tob* "$kobman_env_folder"
mv "$kobman_stage_folder"/kobman-* "$kobman_src_folder"

echo "Set version to $KOBMAN_VERSION ..."
echo "$KOBMAN_VERSION" > "${KOBMAN_DIR}/var/version"


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

sudo chmod a+rwx .
sudo chmod u+xr /home/blockchain/.kobman/candidates
sudo chmod go+x /
sudo chmod go+x /root
echo -e "\n\n\nAll done!\n\n"

echo "Please open a new terminal, or run the following in the existing one:"
echo ""
echo "    source \"${KOBMAN_DIR}/bin/kobman-init.sh\""

echo "    "
echo "Then issue the following command:"
echo ""
echo "    kob help"
echo ""

echo "Enjoy!!!"
