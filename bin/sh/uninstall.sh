#!/bin/bash

echo "                 _            __        _____                   "
echo "    __  ______  (_)___  _____/ /_____ _/ / (_)___  ____ _       "
echo "   / / / / __ \/ / __ \/ ___/ __/ __  / / / / __ \/ __  /       "
echo "  / /_/ / / / / / / / (__  ) /_/ /_/ / / / / / / / /_/ /  _ _ _ "
echo "  \__,_/_/ /_/_/_/ /_/____/\__/\__,_/_/_/_/_/ /_/\__, /  (_|_|_) "
echo "                                                /____/          "




Function_unsetProxyEnv()
{
        unset http_proxy
        unset ftp_proxy
        unset https_proxy
        unset socks_proxy
        unset SOCKS_PROXY
        unset FTP_PROXY
        unset HTTPS_PROXY
        unset HTTP_PROXY
}

Function_unsetUbuntuProxy()
{
        sudo touch /etc/apt/apt.conf

}

Function_uninstall_basic()
{
	sudo apt remove git -y
	sudo apt remove python3.7 -y
        sudo apt-get remove docker docker-engine docker-ce docker-ce-cli docker.io -y

}




Function_unsetProxyEnv
Function_unsetUbuntuProxy
Function_uninstall_basic
