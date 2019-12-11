#!/bin/bash 
                                                              
                                                              
echo "   ________         ____             ____              __  "
echo "  /_  __/ /_  ___  / __ \_________ _/ __ )____  ____  / /__"
echo "   / / / __ \/ _ \/ / / / ___/ __  / __  / __ \/ __ \/ //_/"
echo "  / / / / / /  __/ /_/ / /  / /_/ / /_/ / /_/ / /_/ / ,<   "
echo " /_/ /_/ /_/\___/\____/_/   \__, /_____/\____/\____/_/|_|  "
echo "                           /____/                          "





Function_TOBBuild()
{
           
echo "     ____        _ __    ___                   "
echo "    / __ )__  __(_) /___/ (_)___  ____ _       "
echo "   / __  / / / / / / __  / / __ \/ __  /       "
echo "  / /_/ / /_/ / / / /_/ / / / / / /_/ /  _ _ _ "
echo " /_____/\__,_/_/_/\__,_/_/_/ /_/\__, /  (_|_|_) "
echo "                               /____/           "


		cd $TOB_env_Dir
         	sudo echo "Setting-up TOB instance in your system?"
                sudo git clone https://github.com/bcgov/TheOrgBook.git
                sudo wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo mv s2i sti /usr/local/bin/
                sudo TheOrgBook/docker/manage rm
                sudo TheOrgBook/docker/manage build
                sudo sed -i -e 's/- 3000/- 3100/g' TheOrgBook/docker/docker-compose.yml


}

Function_TobStart()
{

echo "    _____ __             __  _                  "
echo "   / ___// /_____ ______/ /_(_)___  ____ _      "
echo "   \__ \/ __/ __  / ___/ __/ / __ \/ __  /       "
echo "  ___/ / /_/ /_/ / /  / /_/ / / / / /_/ /  _ _ _"
echo " /____/\__/\__,_/_/   \__/_/_/ /_/\__, /  (_|_|_) "
echo "                                 /____/           "


	cd $TOB_env_Dir
	sudo read -p "Do you want to start TOB instance in your system?" reply
        if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
        then
        sudo TheOrgBook/docker/manage start seed=the_org_book_0000000000000000000
        fi
}

fun_uninstall_TOB()
{
	cd $TOB_env_Dir
	sudo TheOrgBook/docker/manage rm
	sudo rm -rf /usr/local/bin/s2i /usr/local/bin/sti TheOrgBook/	
}	
