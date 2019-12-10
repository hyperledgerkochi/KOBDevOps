#!/bin/bash 


##

#Install: stable

# Global variables
# KOBPROJECT_SERVICE="https://api.KOBDevOps.io/2"
echo "   "
echo "   "
echo "   "
echo "   "
echo "   "
echo "   "
echo "   "
echo "   "
echo "   "
echo "   "
echo "   "
echo "     __ ______  ____       _____      __           " 
echo "    / //_/ __ \/ __ )     / ___/___  / /___  ______ "  
echo "   / ,< / / / / __  |_____\__ \/ _ \/ __/ / / / __ \ " 
echo "  / /| / /_/ / /_/ /_____/__/ /  __/ /_/ /_/ / /_/ / " 
echo " /_/ |_\____/_____/     /____/\___/\__/\__,_/  ___/  " 
echo "                                           /_/       " 







# Sanity checks

echo "Looking for a previous installation of KOBPROJECT..."
if [ -d "$KOB_env_Dir" ]; then
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


echo "Uninstalling KOBPROJECT scripts..."

# Removing existing environment variables 
sudo rm -rf /usr/bin/KOB_Dir/ /usr/bin/TOB_Dir/ /usr/bin/sh/ /usr/bin/envv/ /usr/bin/KOB


# Create directory structure

sudo echo "Installing KOBPROJECT scripts..."
sudo echo "Creating KOB_Dir & exporting KOB_env_Dir"
sudo mkdir -p /usr/bin/KOB_Dir
export KOB_env_Dir=/usr/bin/KOB_Dir
sudo echo "Creating TOB_Dir & exporting TOB_env_Dir"
sudo mkdir -p /usr/bin/TOB_Dir
export TOB_env_Dir=/usr/bin/TOB_Dir


 
echo "change to KOB_env_Dir"
cd $KOB_env_Dir
sudo git clone https://github.com/EtricKombat/KOBDevOps.git


echo "This is the present working directory now..."
pwd



sudo cp -r KOBDevOps/bin/sh/ /usr/bin
sudo cp -r KOBDevOps/bin/envv/ /usr/bin
sudo cp -r KOBDevOps/src/bash/KOB /usr/bin

export KOB_SH=/usr/bin/sh
export KOB_ENV=/usr/bin/envv


sudo echo " Giving sufficient permissions " 
cd /usr/bin
sudo chmod -R a+x .
sudo chmod -R a+r .
sudo chmod -R o-w .
sudo chmod -R 777 /usr/bin/envv/
sudo chmod -R 777 /usr/bin/sh/

echo -e "\n\n\nAll done!\n\n"

echo "Please open a new terminal, or run the following in the existing one:"
echo ""
echo ""
echo "    KOB help"
echo ""
echo "Enjoy!!!"
