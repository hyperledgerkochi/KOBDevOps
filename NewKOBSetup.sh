#Install: stable

# Global variables
KOBDEVOPS_VERSION="0.01"
KOBDEVOPS_PLATFORM=$(uname)
mkdir -p $HOME/.kobdevops


if [ -z "$KOBDEVOPS_DIR" ]; then
    export KOBDEVOPS_DIR="$HOME/.kobdevops"
fi

# Local variables

mkdir -p ${KOBDEVOPS_DIR}/bin
mkdir -p ${KOBDEVOPS_DIR}/src
mkdir -p ${KOBDEVOPS_DIR}/env

kobdevops_bin_folder="${KOBDEVOPS_DIR}/bin"
kobdevops_src_folder="${KOBDEVOPS_DIR}/src"
kobdevops_env_folder="${KOBDEVOPS_DIR}/env"

kobdevops_bash_profile="${HOME}/.bash_profile"
kobdevops_profile="${HOME}/.profile"
kobdevops_bashrc="${HOME}/.bashrc"
kobdevops_zshrc="${HOME}/.zshrc"

kobdevops_init_snippet=$( cat << EOF
#THIS MUST BE AT THE END OF THE FILE FOR KOBDEVOPS TO WORK!!!
export KOBDEVOPS_DIR="$KOBDEVOPS_DIR"
[[ -s "${KOBDEVOPS_DIR}/bin/kobdevops-init.sh" ]] && source "${KOBDEVOPS_DIR}/bin/kobdevops-init.sh"
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

echo "     __ ______  ____       _____      __           "
echo "    / //_/ __ \/ __ )     / ___/___  / /___  ______ "
echo "   / ,< / / / / __  |_____\__ \/ _ \/ __/ / / / __ \ "
echo "  / /| / /_/ / /_/ /_____/__/ /  __/ /_/ /_/ / /_/ / "
echo " /_/ |_\____/_____/     /____/\___/\__/\__,_/  ___/  "
echo "                                           /_/       "

# Sanity checks

echo "Looking for a previous installation of KOBDEVOPS..."
if [ -d "$KOBDEVOPS_DIR" ]; then
	echo "KOBDEVOPS found."
	echo ""
	echo "======================================================================================================"
	echo " You already have KOBDEVOPS installed."
	echo " KOBDEVOPS was found at:"
	echo ""
	echo "    ${KOBDEVOPS_DIR}"
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
		echo " KOBDEVOPS uses gsed extensively."
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


echo "Installing KOBDEVOPS scripts..."


# Create directory structure

echo "Create distribution directories..."
mkdir -p "$kobdevops_bin_folder"
mkdir -p "$kobdevops_src_folder"
mkdir -p "$kobdevops_env_folder"




echo "Extract script archive..."
if [[ "$cygwin" == 'true' ]]; then
	echo "Cygwin detected - normalizing paths for unzip..."
	kobdevops_zip_file=$(cygpath -w "$kobdevops_zip_file")
	kobdevops_stage_folder=$(cygpath -w "$kobdevops_stage_folder")
fi
unzip -qo "$kobdevops_zip_file" -d "$kobdevops_stage_folder"



if [[ $darwin == true ]]; then
  touch "$kobdevops_bash_profile"
  echo "Attempt update of login bash profile on OSX..."
  if [[ -z $(grep 'kobdevops-init.sh' "$kobdevops_bash_profile") ]]; then
    echo -e "\n$kobdevops_init_snippet" >> "$kobdevops_bash_profile"
    echo "Added kobdevops init snippet to $kobdevops_bash_profile"
  fi
else
  echo "Attempt update of interactive bash profile on regular UNIX..."
  touch "${kobdevops_bashrc}"
  if [[ -z $(grep 'kobdevops-init.sh' "$kobdevops_bashrc") ]]; then
      echo -e "\n$kobdevops_init_snippet" >> "$kobdevops_bashrc"
      echo "Added kobdevops init snippet to $kobdevops_bashrc"
  fi
fi

echo "Attempt update of zsh profile..."
touch "$kobdevops_zshrc"
if [[ -z $(grep 'kobdevops-init.sh' "$kobdevops_zshrc") ]]; then
    echo -e "\n$kobdevops_init_snippet" >> "$kobdevops_zshrc"
    echo "Updated existing ${kobdevops_zshrc}"
fi

echo -e "\n\n\nAll done!\n\n"

echo "Please open a new terminal, or run the following in the existing one:"
echo ""
echo "    source \"${KOBDEVOPS_DIR}/bin/kobdevops-init.sh\""
echo ""
echo "Then issue the following command:"
echo ""
echo "    kob help"
echo ""
echo "Enjoy!!!"
