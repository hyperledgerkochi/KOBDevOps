#!/bin/bash



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
mkdir -p /usr/bin/KOB_Dir
export KOB_Dir=/usr/bin/KOB_Dir
cd $KOB_Dir 
sudo git clone https://github.com/EtricKombat/KOBDevOps.git
cd /KOBDevOps/bin

sudo mv KOBDevOps/bin/sh KOBDevOps/bin/env /usr/bin
# sudo mv KOBDevOps/bin/env /usr/bin 
echo " available KOB_ENVs..."
export KOB_SH=/usr/bin/sh
export KOB_ENV=/usr/bin/env








echo -e "\n\n\nAll done!\n\n"

echo "Please open a new terminal, or run the following in the existing one:"
echo ""
echo ""
echo "    KOB help"
echo ""
echo "Enjoy!!!"
