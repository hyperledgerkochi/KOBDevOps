#!/bin/bash

echo "      _            __        _____                   "
echo "     (_)___  _____/ /_____ _/ / (_)___  ____ _       "
echo "    / / __ \/ ___/ __/ __  / / / / __ \/ __  /       "
echo "   / / / / (__  ) /_/ /_/ / / / / / / / /_/ /  _ _ _ "
echo "  /_/_/ /_/____/\__/\__,_/_/_/_/_/ /_/\__, /  (_|_|_) "
echo "                                     /____/           "



Function_VimFix()
{
        sudo cd
        sudo echo "set nocompatible" > /root/.vimrc
}



Function_UbuntuUpgrade()
{
        sudo echo -e "\n\r***********************************";
        sudo echo "*       Updating your OS?         *";
        sudo echo "***********************************";

        sudo echo "Updating system......";
        sudo apt-get update -y
        sudo apt-get dist-upgrade -y
}

Function_ProxyEnv()
{
        unset http_proxy
        unset ftp_proxy
        unset https_proxy
        unset socks_proxy
        unset SOCKS_PROXY
        unset FTP_PROXY
        unset HTTPS_PROXY
        unset HTTP_PROXY
        export HTTPS_PROXY=http://${uname}:${pword}@${prox}:${port}/
        export HTTP_PROXY=http://${uname}:${pword}@${prox}:${port}/
        export FTP_PROXY=ftp://${uname}:${pword}@${prox}:${port}/
        export SOCKS_PROXY=socks://${uname}:${pword}@${prox}:${port}/

        export http_proxy=http://${uname}:${pword}@${prox}:${port}/
        export https_proxy=http://${uname}:${pword}@${prox}:${port}/
        export ftp_proxy=ftp://${uname}:${pword}@${prox}:${port}/
        export socks_proxy=socks://${uname}:${pword}@${prox}:${port}/
        env | grep -i proxy
}


Function_CheckProxy()
{
        read -p "Are you behind a corporate proxy?" reply
	if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ]
then
        proxychk=1
        sudo dpkg --configure -a
        read -s -p "Enter the proxy?[eg: Kochin.dummy.com..etc] :" prox
        sudo echo -e "\n"
        read -s -p "Enter the port?[eg :8080,443..etc]          :" port
        sudo echo -e "\n"
        read -s -p "Enter AD ID? [eg :ai318974]                 :" uname
        read -s -p "Enter password?[your login password]        : " pword
        sudo echo -e "\n"
        read -s -p "Enter email ID?                             :" emil
        Function_ProxyEnv
        for proto in http https ftp socks;
        do
                if [ "$proto" = "https" ];
                then
                  sudo printf 'Acquire::%s::proxy "http://%s:%s@%s:%u/";\n' "$proto" "$uname" "$pword" "$prox" "$port"
                else
                        sudo printf 'Acquire::%s::proxy "%s://%s:%s@%s:%u/";\n' "$proto" "$proto" "$uname" "$pword" "$prox" "$port"
                fi

        done | sudo tee -a /etc/apt/apt.conf > /dev/null
        sudo mkdir -p /etc/systemd/system/docker.service.d/
 	sudo touch /etc/systemd/system/docker.service.d/https-proxy.conf
        sudo chmod 777 /etc/systemd/system/docker.service.d/https-proxy.conf
	sudo echo -e "[Service]\nEnvironment="HTTPS_PROXY=http://${uname}:${pword}@${prox}:${port}"">>/etc/systemd/system/docker.service.d/https-proxy.conf

        sudo echo "**********************"
        sudo git config --global user.name "${uname}"
        sudo git config --global user.email "${emil}"
        sudo apt install ca-certificates -y
        sudo git config --global http.sslVerify false
        sudo git config --global http.proxy http://${uname}:${pword}@${prox}:${port}
else
        sudo echo "skipping the proxy settings"
fi

}



Function_GitInstall()
{
        sudo echo -e "\n\r**********************************";
        sudo echo "*     Installing Git?            *";
        sudo echo "**********************************";

        sudo apt install git -y
        sudo git --version

}




Function_PythonInstall()
{
        sudo echo -e "\n\r**********************************";
        sudo echo "*      Installing Python?        *"
        sudo echo "**********************************"
        sudo apt install software-properties-common -y
        sudo apt install Python3.7 -y
        sudo apt install python-pip -y


}


Function_DockerInstall()
{
        sudo echo "*  Uninstalling Exising Docker...*";
        sudo echo "**********************************";

        sudo sudo apt-get remove docker docker-engine docker-ce docker-ce-cli docker.io -y

        sudo echo -e "\n\r**********************************";
        sudo echo "*    Installing Docker...         *";
        sudo echo -e "**********************************\n\n\r";
        sudo apt-get update -y
        sudo apt install docker.io -y
        sudo echo -e "\n\r************************************************************************";
        sudo echo "*    Installing packages to allow apt to use a repository over HTTPS...   *";
        sudo echo -e "*************************************************************************\n\n\r";



        sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

        sudo echo -e "\n\r******************************";
        sudo echo "*    Add Dockers official GPG key... *";
        sudo echo -e "*********************************\n\n\r";
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

        sudo echo -e "\n\r***********************************************************";
        sudo echo "*    Verifying that you now have the key with the fingerprint: *";
        sudo echo -e "*********************************************************\n\n\r";
        sudo apt-key fingerprint 0EBFCD88


        sudo echo -e "\n\n\r**********************************";
        sudo echo "*     setting up the stable repository...  *";
        sudo echo "**********************************";
        lsb_release -cs
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"

        sudo echo -e "\n\r**********************************";
        sudo echo "*    Installing Docker Engine...*";
        sudo echo "**********************************";
        sudo apt-get update -y
        sudo apt-get install docker-ce docker-ce-cli containerd.io -y
        sudo docker run hello-world


        sudo echo -e "\n\r***********************************";
        sudo echo "*    Installing Docker Compose?   *";
        sudo echo "***********************************";
        sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

        sudo chmod +x /usr/local/bin/docker-compose
        sudo echo -e "\n\r**********************************";
        sudo echo "*     Docker & Docker compose Version     *";
        sudo echo "**********************************";
        sudo systemctl start docker
        sudo systemctl enable docker
        sudo docker --version
        sudo docker-compose --version
        sudo echo -e "\n\r**********************************";
        sudo echo -e "\n\r*    Docker Login                *"
        sudo echo -e "\n\r**********************************";
        sudo rm -rf /root/.docker/
        sudo docker login

        if [[ "$proxychk" -eq 1 ]]
        then
                sudo sed -i '$ d' /root/.docker/config.json
                sudo echo -e ",\n "\""proxies"\"": {\n\t "\""default"\"": {\n\t\t "\""httpProxy"\"": "\""http://${uname}:${pword}@${prox}:${port}"\"",\n\t\t "\""httpsProxy"\"": "\""https://${uname}:${pword}@${prox}:${port}"\"",\n\t\t "\""noProxy"\"": "\""localhost,127.0.0.0/8,*.local,host.docker.internal"\"" \n\t\t}\n\t}\n}">>/root/.docker/config.json
        fi

}

Function_NpmInstall()
{
        sudo echo -e "\n\r***********************************";
        sudo echo "*    Purging NPM Components              *";
        sudo echo -e "\n\r***********************************";
        npm config rm proxy
        npm config rm proxy --global

        npm config rm https-proxy
        npm config rm https-proxy --global

        npm config rm registry
        npm cache clean

        sudo sudo apt-get remove nodejs nodejs-dev node-gyp libssl1.0-dev npm
        sudo echo "Ignore!! these errors"

        sudo echo -e "\n\r***********************************";
        sudo echo "*    Installing NPM Components              *";
        sudo echo -e "\n\r***********************************";

        sudo sudo apt-get install nodejs nodejs-dev node-gyp libssl1.0-dev npm -y

        npm config set https-proxy http://${uname}:${pword}@${prox}:${port}--global
        npm config set https-proxy http://${uname}:${pword}@${prox}:${port}

        npm config set proxy http://${uname}:${pword}@${prox}:${port}--global
        npm config set proxy http://${uname}:${pword}@${prox}:${port}

        npm config set registry http://registry.npmjs.org
        npm config set strict-ssl false

}


