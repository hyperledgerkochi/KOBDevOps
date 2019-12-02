#!/bin/bash

echo "     __ ______  ____        ______                            __ "
echo "    / //_/ __ \/ __ )      / ____/___  ____  ____  ___  _____/ /_"
echo "   / ,< / / / / __  |_____/ /   / __ \/ __ \/ __ \/ _ \/ ___/ __/"
echo "  / /| / /_/ / /_/ /_____/ /___/ /_/ / / / / / / /  __/ /__/ /_  "
echo " /_/ |_\____/_____/      \____/\____/_/ /_/_/ /_/\___/\___/\__/  "



Function_KOBConnect()
{

echo "     ____        _ __    ___                   "
echo "    / __ )__  __(_) /___/ (_)___  ____ _       "
echo "   / __  / / / / / / __  / / __ \/ __  /       "
echo "  / /_/ / /_/ / / / /_/ / / / / / /_/ /  _ _ _ "
echo " /_____/\__,_/_/_/\__,_/_/_/ /_/\__, /  (_|_|_) "
echo "                               /____/           "



		cd $KOB_env_Dir
		sudo git clone https://github.com/hyperledgerkochi/KOBConnect.git
}

fun_uninstall_KOBConnect()
{

	cd $KOB_env_Dir
	sudo rm -rf KOBConnect/
}
