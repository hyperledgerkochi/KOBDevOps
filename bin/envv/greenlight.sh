#!/bin/bash 


echo "                                ___       __    __ "
echo "    ____ _________  ___  ____  / (_)___ _/ /_  / /_ "
echo "   / __  / ___/ _ \/ _ \/ __ \/ / / __  / __ \/ __/ "
echo "  / /_/ / /  /  __/  __/ / / / / / /_/ / / / / /_  "
echo "  \__, /_/   \___/\___/_/ /_/_/_/\__, /_/ /_/\__/  "
echo " /____/                         /____/             "




export TOB_dir=/usr/bin/env/tob


Function_greenlight_build()
{
                sudo echo "Build greenlight instance in your system"

                sudo git clone https://github.com/bcgov/greenlight.git
                sudo wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo mv s2i sti /usr/local/bin/
                sudo /home/TOB/greenlight/docker/manage rm
                sudo /home/TOB/greenlight/docker/manage build



}

fun_greenlight_start()
{
        sudo read -p "Start KOBDflow instance in your system?" reply
        if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
        then
                sudo /home/TOB/greenlight/docker/manage start
        fi
}


