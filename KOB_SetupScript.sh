#!/bin/bash
clear

echo "******************"
echo "*                *"
echo "* PRE-REQUISITES *"
echo "*                *"
echo "******************"

echo "> Ubuntu Bionic 18.04 (LTS)"
echo "> Login as root user"
echo "> Mininum 4GB RAM is required to set this env up"
echo "> No special character should be present in your password"
echo "*****************************************"


read -p "Confirm that you read and understood the above listed pre-requests with 'yes' for proceeding with the KOB-Dev Setup steps?" reply

if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];

then

	echo "*****************************************"
	echo "* Proceeding with the KOB- Dev Setup    *" 
	echo "*****************************************" 
else
	exit
fi	
cd 
echo "set nocompatible" > /root/.vimrc
clear

echo "****************BeSecureOrg Setup***************************";


echo "************************************************************"
echo "*   Agreed/Confirmed Pre-Requesites listed below           * "
echo "************************************************************"
echo "*                                                          *"
echo "*- you are using Ubuntu Bionic 18.04 (LTS)                 *"
echo "*  [To install Docker Engine - Community                   *"
echo "*- Login as root user                                      *"
echo "*- Mininum 4GB RAM is required to set this env up          *"
echo "*- No special character in password                        *"
echo "************************************************************"



echo "************************************************************"
echo "*The installation that can be performed by you:            *"
echo "*         Requires (yes/no) input                          *"
echo "*1)Ubuntu Update & Upgrade                                 *"
echo "*2)Git                                                     *"
echo "*3)Python                                                  *"
echo "*4)Docker                                                  *"
echo "*5)Docker Compose                                          *"
echo "*6)VON Network Build                                       *"
echo "*7)TOB Build                                               *"
echo "*8)Von Network Start-up                                    *"
echo "*                                                          *"
echo "************************************************************"

echo -e "\n\r***********************************";

echo "*       Using Proxy?         *";

echo "***********************************";



read -p "Are you behind a corporate proxy?" reply
if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];

then
        read -p "Enter the proxy?[eg: Kochin.dummy.com..etc] :" prox
        read -p "Enter the port?[eg :8080,443..etc]          :" port
        read -p "Enter AD ID? [eg :ai318974]                 :" uname
        read -p "Enter password?[your login password]        :" pword
        unset http_proxy
        unset ftp_proxy
        unset https_proxy
        unset socks_proxy
        unset SOCKS_PROXY
        unset FTP_PROXY
        unset HTTPS_PROXY
        unset HTTP_PROXY

        for proto in http https ftp socks;
        do
                if [ "$proto" = "https" ];
                then
                  printf 'Acquire::%s::proxy "http://%s:%s@%s:%u/";\n' "$proto" "$uname" "$pword" "$prox" "$port"
                else
                        printf 'Acquire::%s::proxy "%s://%s:%s@%s:%u/";\n' "$proto" "$proto" "$uname" "$pword" "$prox" "$port"
                fi

        done | sudo tee -a /etc/apt/apt.conf > /dev/null


        export HTTPS_PROXY=http://${uname}:${pword}@${prox}:${port}/
        export HTTP_PROXY=http://${uname}:${pword}@${prox}:${port}/
        export FTP_PROXY=ftp://${uname}:${pword}@${prox}:${port}/
        export SOCKS_PROXY=socks://${uname}:${pword}@${prox}:${port}/

        echo -e "\n\r*****Env Variable after*********"
        env | grep -i proxy
        echo "**********************\n\r"
        apt install ca-certificates
	git config --global http.sslVerify false
        git config --global http.proxy http://${uname}:${pword}@${prox}:${port}
else
        echo "skipping the proxy settings"
fi





#Updating & Upgrading Ubuntu 18.04

echo -e "\n\r***********************************";
echo "*       Updating your OS?         *";
echo "***********************************";

read -p "Do you Want to Update & Upgrade your system?" reply
if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
then

        echo "Updating system......";
        apt-get update -y
        apt-get upgrade -y
else
        echo -e "\n\r******Skipping System Updating*****";
fi


#Installing Git & Printing version

echo -e "\n\r**********************************";
echo "*     Installing Git?            *";
echo "**********************************";

read -p "Do you want to install git your system?" reply
if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
then
        apt install git -y
        git --version
else
        echo -e "\n\r****Skipping Git Installation*****";
fi

echo -e "\n\r**********************************";
echo "*      Installing Python?        *"
echo "**********************************"

read -p "Do you want to install Python your system?" reply
if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
then
        apt install software-properties-common -y
        sudo -E add-apt-repository ppa:ubuntu-toolchain-r/ppa
 	apt install Python3.7 -y
else
        echo -e "\n\r**Skipping Python Installation****"
fi

echo -e "\n\r**********************************";
echo "*      Installing Docker?        *"
echo "**********************************"

read -p "Do you want to install Docker in your system?  " reply
if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
then
        echo -e "\n\r**********************************";
        echo "*  Uninstalling Exising Docker...*";
        echo "**********************************";

        sudo apt-get remove docker docker-engine docker-ce docker-ce-cli docker.io

        echo -e "\n\r**********************************";
        echo "*    Installing Docker...         *";
        echo -e "**********************************\n\n\r";
        apt-get update -y
        apt install docker.io
        systemctl start docker
        systemctl enable docker
        echo -e "\n\r************************************************************************";
        echo "*    Installing packages to allow apt to use a repository over HTTPS...   *";
        echo -e "*************************************************************************\n\n\r";



        apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

        echo -e "\n\r******************************";
        echo "*    Add Dockers official GPG key... *";
        echo -e "*********************************\n\n\r";
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

        echo -e "\n\r***********************************************************";
        echo "*    Verifying that you now have the key with the fingerprint: *";
        echo -e "*********************************************************\n\n\r";
        apt-key fingerprint 0EBFCD88


        echo -e "\n\n\r**********************************";
        echo "*     setting up the stable repository...  *";
        echo "**********************************";
        lsb_release -cs
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"

        echo -e "\n\r**********************************";
        echo "*    Installing Docker Engine...*";
        echo "**********************************";
        apt-get update -y
        apt-get install docker-ce docker-ce-cli containerd.io -y
        docker run hello-world
else
        echo "**Skipping Docker Installation****";
fi


echo -e "\n\r***********************************";
echo "*    Installing Docker Compose?   *";
echo "***********************************";
read -p "Do you want to install Docker compose in your system?" reply
if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
then
        curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

        chmod +x /usr/local/bin/docker-compose
        echo -e "\n\r**********************************";
        echo "*     Docker & Docker compose Version     *";
        echo "**********************************";
        docker --version
        docker-compose --version
else
        echo "Skipping Docker Compose Installation";
fi



echo -e "\n\r***********************************";
echo "*    Setting up VON?               *";
echo "***********************************";
read -p "Do you want to setup VON network in your system?  " reply
if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
then

        apt-get -y install build-essential nghttp2 libnghttp2-dev libssl-dev
        mkdir -p /home/KochiOrgBook
	cd /home/KochiOrgBook
	git clone https://github.com/hyperledgerkochi/von-network.git
	/home/KochiOrgBook/von-network/manage build
else
        echo "Skipping Without setting up VON...";
fi

echo -e "\n\r***********************************";
echo "*    Setting up TOB?               *";
echo "***********************************";
read -p "Do you want to setup TheOrgBook instance in your system?" reply
if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
then
        apt-get -y install build-essential nghttp2 libnghttp2-dev libssl-dev npm
	mkdir -p /home/KochiOrgBook
        cd /home/KochiOrgBook
        git clone https://github.com/hyperledgerkochi/TheOrgBook.git
        wget https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
        tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
        mv s2i sti /usr/local/bin/
        /home/KochiOrgBook/TheOrgBook/docker/manage build
else
        echo -e "\n\r**********************************";
        echo "*Skipping Without setting up TOB *";
        echo "**********************************";
fi

read -p "Starting VON Network build....?" reply
if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
then
        /home/KochiOrgBook/von-network/manage start 
fi

echo -e "\n\n\r\r*****************";
echo " Try to use the listed links and confirm the health status of Von Netowrk";

	echo "Von Network project"

	echo "********************"
	echo "                    "
	echo "https://localhost:9000/"
	echo -e "\n\r"
	echo "TheOrgBook project"
 	echo "********************"
	echo "http://localhost:8080/ [ main UI is exposed] "
        echo "http://localhost:8081/ [API is exposed] "
        echo "http://localhost:8082/ [schema-spy is exposed] "
        echo "http://localhost:8983/ [solr is exposed] "
        echo "                    "
	echo "Greenlight project"
	echo "********************"

