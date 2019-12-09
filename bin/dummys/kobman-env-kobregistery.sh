#!/bin/bash 

echo "     __ ______  ____        ____             _      __            "
echo "    / //_/ __ \/ __ )      / __ \___  ____ _(_)____/ /____  _______  __ "
echo "   / ,< / / / / __  |_____/ /_/ / _ \/ __  / / ___/ __/ _ \/ ___/ / / / "
echo "  / /| / /_/ / /_/ /_____/ _, _/  __/ /_/ / (__  ) /_/  __/ /  / /_/ / "
echo " /_/ |_\____/_____/     /_/ |_|\___/\__, /_/____/\__/\___/_/   \__, /  "
echo "                                   /____/                     /____/   "



Function_KOBRegistery()
{

echo "     ____        _ __    ___                   "
echo "    / __ )__  __(_) /___/ (_)___  ____ _       "
echo "   / __  / / / / / / __  / / __ \/ __  /       "
echo "  / /_/ / /_/ / / / /_/ / / / / / /_/ /  _ _ _ "
echo " /_____/\__,_/_/_/\__,_/_/_/ /_/\__, /  (_|_|_) "
echo "                               /____/           "



		cd $KOB_env_Dir
		sudo git clone https://github.com/hyperledgerkochi/KOBRegistry.git
}

fun_uninstall_KOBRegistery()
{
	cd $KOB_env_Dir
	sudo rm -rf KOBRegistry/

}
