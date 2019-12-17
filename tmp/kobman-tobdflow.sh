#!/bin/bash 


function __kobman_greenlight_build
{

echo "     ____        _ __    ___                   "
echo "    / __ )__  __(_) /___/ (_)___  ____ _       "
echo "   / __  / / / / / / __  / / __ \/ __  /       "
echo "  / /_/ / /_/ / / / /_/ / / / / / /_/ /  _ _ _ "
echo " /_____/\__,_/_/_/\__,_/_/_/ /_/\__, /  (_|_|_) "
echo "                               /____/           "

		figlet Building greenlight
 		cd ${KOBMAN_CANDIDATES_DIR}
                sudo git clone https://github.com/bcgov/greenlight.git
                sudo wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo mv s2i sti /usr/local/bin/
                sudo greenlight/docker/manage rm
                sudo greenlight/docker/manage build



}

function __kobman_greenlight_start
{


	figlet starting greenlight
 	cd ${KOBMAN_CANDIDATES_DIR}
        sudo read -p "Start KOBDflow instance in your system?" reply
        if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
        then
                sudo greenlight/docker/manage start
        fi
}

function __kobman_greenlight_uninstall
{
	
	figlet Removing greenlight
 	cd ${KOBMAN_CANDIDATES_DIR}
	sudo greenlight/docker/manage rm
	sudo rm -rf greenlight/ /usr/local/bin/sti /usr/local/bin/s2i source-to-image-v1.1.14-874754de-linux-amd64.tar.gz	
}
