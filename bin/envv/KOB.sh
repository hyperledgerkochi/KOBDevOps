#!/bin/bash

 
                                                          
echo "     __ __           __    _ ____             ____              __  "
echo "    / //_/___  _____/ /_  (_) __ \_________ _/ __ )____  ____  / /__"
echo "   /    / __ \/ ___/ __ \/ / / / / ___/ __  / __  / __ \/ __ \/ //_/"
echo "  / /| / /_/ / /__/ / / / / /_/ / /  / /_/ / /_/ / /_/ / /_/ / ,<   "
echo " /_/ |_\____/\___/_/ /_/_/\____/_/   \__, /_____/\____/\____/_/|_|  "
echo "                                    /____/                          "




Function_KobBuild()
{

echo "     ____        _ __    ___                   "
echo "    / __ )__  __(_) /___/ (_)___  ____ _       "
echo "   / __  / / / / / / __  / / __ \/ __  /       "
echo "  / /_/ / /_/ / / / /_/ / / / / / /_/ /  _ _ _ "
echo " /_____/\__,_/_/_/\__,_/_/_/ /_/\__, /  (_|_|_) "
echo "                               /____/           "

		cd $KOB_env_Dir
		sudo git clone https://github.com/EtricKombat/TheOrgBook.git
                sudo wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo mv s2i sti /usr/local/bin/
                sudo TheOrgBook/docker/manage rm
                sudo TheOrgBook/docker/manage build
                sudo sed -i -e 's/- 3000/- 3100/g' /home/KOB/TheOrgBook/docker/docker-compose.yml


}

Function_KobStart()
{

echo "    _____ __             __  _                  "
echo "   / ___// /_____ ______/ /_(_)___  ____ _      "
echo "   \__ \/ __/ __  / ___/ __/ / __ \/ __  /       "
echo "  ___/ / /_/ /_/ / /  / /_/ / / / / /_/ /  _ _ _"
echo " /____/\__/\__,_/_/   \__/_/_/ /_/\__, /  (_|_|_) "
echo "                                 /____/           "
~                                                                                         
~    
	sudo read -p "Do you want to start KOB instance in your system?" reply
        if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
        then
        sudo TheOrgBook/docker/manage start seed=the_org_book_0000000000000000000
        fi
}

