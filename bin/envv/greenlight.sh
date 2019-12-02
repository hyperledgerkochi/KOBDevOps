#!/bin/bash 


echo "                                ___       __    __ "
echo "    ____ _________  ___  ____  / (_)___ _/ /_  / /_ "
echo "   / __  / ___/ _ \/ _ \/ __ \/ / / __  / __ \/ __/ "
echo "  / /_/ / /  /  __/  __/ / / / / / /_/ / / / / /_  "
echo "  \__, /_/   \___/\___/_/ /_/_/_/\__, /_/ /_/\__/  "
echo " /____/                         /____/             "





Function_greenlight_build()
{

echo "     ____        _ __    ___                   "
echo "    / __ )__  __(_) /___/ (_)___  ____ _       "
echo "   / __  / / / / / / __  / / __ \/ __  /       "
echo "  / /_/ / /_/ / / / /_/ / / / / / /_/ /  _ _ _ "
echo " /_____/\__,_/_/_/\__,_/_/_/ /_/\__, /  (_|_|_) "
echo "                               /____/           "

		cd $TOB_env_Dir
                sudo git clone https://github.com/bcgov/greenlight.git
                sudo wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo mv s2i sti /usr/local/bin/
                sudo greenlight/docker/manage rm
                sudo greenlight/docker/manage build



}

fun_greenlight_start()
{

echo "    _____ __             __  _                  "
echo "   / ___// /_____ ______/ /_(_)___  ____ _      "
echo "   \__ \/ __/ __  / ___/ __/ / __ \/ __  /       "
echo "  ___/ / /_/ /_/ / /  / /_/ / / / / /_/ /  _ _ _"
echo " /____/\__/\__,_/_/   \__/_/_/ /_/\__, /  (_|_|_) "
echo "                                 /____/           "

	cd $TOB_env_Dir
        sudo read -p "Start KOBDflow instance in your system?" reply
        if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
        then
                sudo greenlight/docker/manage start
        fi
}

fun_uninstall_greenlight()
{
	
	cd $TOB_env_Dir
	sudo greenlight/docker/manage rm
	sudo rm -rf greenlight/ /usr/local/bin/sti /usr/local/bin/s2i source-to-image-v1.1.14-874754de-linux-amd64.tar.gz	
}
