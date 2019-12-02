#!/bin/bash 

                                                                                                                      
echo "  _    ______  _   __      __ ______  ____ "
echo " | |  / / __ \/ | / /     / //_/ __ \/ __ )"
echo " | | / / / / /  |/ /_____/ ,< / / / / __ | "
echo " | |/ / /_/ / /|  /_____/ /| / /_/ / /_/ / "
echo " |___/\____/_/ |_/     /_/ |_\____/_____/  "




Function_VonBuild()
{
echo "     ____        _ __    ___                   "
echo "    / __ )__  __(_) /___/ (_)___  ____ _       "
echo "   / __  / / / / / / __  / / __ \/ __  /       "
echo "  / /_/ / /_/ / / / /_/ / / / / / /_/ /  _ _ _ "
echo " /_____/\__,_/_/_/\__,_/_/_/ /_/\__, /  (_|_|_) "
echo "                               /____/           "


		cd $KOB_env_Dir
                sudo echo "Build KOB-Von instance in your system"
                sudo git clone https://github.com/hyperledgerkochi/von-network.git
                sudo von-network/manage rm
                sudo von-network/manage build

}

Function_VonStart()
{
echo "    _____ __             __  _                  "
echo "   / ___// /_____ ______/ /_(_)___  ____ _      "
echo "   \__ \/ __/ __  / ___/ __/ / __ \/ __  /       "
echo "  ___/ / /_/ /_/ / /  / /_/ / / / / /_/ /  _ _ _"
echo " /____/\__/\__,_/_/   \__/_/_/ /_/\__, /  (_|_|_) "
echo "                                 /____/           "


	cd $KOB_env_Dir
        sudo von-network/manage start
}

fun_uninstall_KOBVON()
{
	cd $KOB_env_Dir
        sudo von-network/manage start
	sudo von-network/manage rm
	sudo rm -rf von-network/
}
