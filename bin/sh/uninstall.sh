#!/bin/bash



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
