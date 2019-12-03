
# https://asciinema.org/a/mnPb27iuQTEjMjuLn9c3iUDmi


#Install: stable

# Global variables
KOBMAN_VERSION="0.01"
KOBMAN_PLATFORM=$(uname)
#mkdir -p $HOME/.kobman



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

if [ -z "$KOBMAN_DIR" ]; then
    export KOBMAN_DIR="$HOME/.kobman"
fi

# Local variables

sudo mkdir -p ${KOBMAN_DIR}/bin
sudo mkdir -p ${KOBMAN_DIR}/src
sudo mkdir -p ${KOBMAN_DIR}/env

kobman_bin_folder="${KOBMAN_DIR}/bin"
kobman_src_folder="${KOBMAN_DIR}/src"
kobman_env_folder="${KOBMAN_DIR}/env"

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


echo "     "
echo "     "
echo "     "
echo "     "
echo "     "
echo "     "
echo "     "
echo "     "
echo "     __ ______  ____       _____      __           "
echo "    / //_/ __ \/ __ )     / ___/___  / /___  ______ "
echo "   / ,< / / / / __  |_____\__ \/ _ \/ __/ / / / __ \ "
echo "  / /| / /_/ / /_/ /_____/__/ /  __/ /_/ /_/ / /_/ / "
echo " /_/ |_\____/_____/     /____/\___/\__/\__,_/  ___/  "
echo "                                           /_/       "


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
mkdir -p "$kobman_env_folder"

cd $kobman_src_folder
echo "Entered kobman_src_folder"
sudo wget -L https://raw.githubusercontent.com/EtricKombat/KOBDevOps/master/main.tar.gz

sudo tar xvfz main.tar.gz main/
sudo mv main/ ${KOBMAN_DIR}/src/

# sudo rm -rf ${KOBMAN_DIR}/src/main.tar.gz
# These are not working need to remove once replacment command found
# rm  ${KOBMAN_DIR}/bin/bin.tar.gz
# rm -rf ${KOBMAN_DIR}/bin/bin
# rm  -rf ${KOBMAN_DIR}/bin/bin.tar.gz
# rm -rf ${KOBMAN_DIR}/bin/bin/

# Hardcoded need to replaced

sudo rm -rf /home/blockchain/.kobman/src/main.tar.gz
cd ../
echo "Exiting kobman_env_folder"

echo "Extract script archive..."
if [[ "$cygwin" == 'true' ]]; then
	echo "Cygwin detected - normalizing paths for unzip..."
	kobman_zip_file=$(cygpath -w "$kobman_zip_file")
	kobman_stage_folder=$(cygpath -w "$kobman_stage_folder")
fi
unzip -qo "$kobman_zip_file" -d "$kobman_stage_folder"



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
echo "    source \"${KOBMAN_DIR}/bin/kobman-init.sh\""
echo ""
echo "Then issue the following command:"
echo ""
echo "    kob help"
echo ""
echo "Enjoy!!!"
