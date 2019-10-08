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

echo "****************KOB- Setup***************************";


echo "************************************************************"
echo "*   Agreed/Confirmed Pre-Requesites listed below           * "
echo "************************************************************"
echo "*                                                          *"
echo "*- you are using Ubuntu Bionic 18.04 (LTS)                 *"
echo "*  To install Docker Engine - Community                   *"
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
echo "*8)green light Build                                       *"
echo "*9)Von Network Start-up                                    *"
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
        read -p "Enter email ID?                             :" emil
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
	mkdir -p /etc/systemd/system/docker.service.d/
	touch /etc/systemd/system/docker.service.d/https-proxy.conf
        echo -e "[Service]\nEnvironment="HTTPS_PROXY=http://${uname}:${pword}@${prox}:${port}"">>/etc/systemd/system/docker.service.d/https-proxy.conf
        
	export HTTPS_PROXY=http://${uname}:${pword}@${prox}:${port}/
        export HTTP_PROXY=http://${uname}:${pword}@${prox}:${port}/
        export FTP_PROXY=ftp://${uname}:${pword}@${prox}:${port}/
        export SOCKS_PROXY=socks://${uname}:${pword}@${prox}:${port}/

	export http_proxy=http://${uname}:${pword}@${prox}:${port}/
	export https_proxy=http://${uname}:${pword}@${prox}:${port}/
	export ftp_proxy=ftp://${uname}:${pword}@${prox}:${port}/
	export socks_proxy=socks://${uname}:${pword}@${prox}:${port}/

        echo "**********************\n\r"
	git config --global user.name "${uname}"
	git config --global user.email "${emil}"
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

        echo "Updating system......";
        apt-get update -y
        apt-get upgrade -y


#Installing Git & Printing version

echo -e "\n\r**********************************";
echo "*     Installing Git?            *";
echo "**********************************";

        apt install git -y
        git --version

echo -e "\n\r**********************************";
echo "*      Installing Python?        *"
echo "**********************************"

        apt install software-properties-common -y
        sudo -E add-apt-repository ppa:ubuntu-toolchain-r/ppa
 	apt install Python3.7 -y


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


echo -e "\n\r***********************************";
echo "*    Installing Docker Compose?   *";
echo "***********************************";
        curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

        chmod +x /usr/local/bin/docker-compose
        echo -e "\n\r**********************************";
        echo "*     Docker & Docker compose Version     *";
        echo "**********************************";
	docker --version
        docker-compose --version
        echo -e "\n\r**********************************";
	echo -e "\n\r*    Docker Login                *"	
        echo -e "\n\r**********************************";
	rm -rf /root/.docker/config.json
       	docker login
	sed -i '$ d' /root/.docker/config.json	
	echo -e ",\n "proxies": {\n\t\t "default": {\n\t\t\t "httpProxy": "http://${uname}:${pword}@${prox}:${port}",\n\t\t\t "httpsProxy": "https://${uname}:${pword}@${prox}:${port}",\n\t\t\t "noProxy": "localhost,127.0.0.0/8,*.local,host.docker.internal"\n\t\t}\n\t}}">>/root/.docker/config.json


echo -e "\n\r***********************************"; 
echo "*    Purging NPM Components              *"; 
echo -e "\n\r***********************************"; 
npm config rm proxy
npm config rm proxy --global

npm config rm https-proxy
npm config rm https-proxy --global

npm config rm registry
npm cache clean

sudo apt-get remove nodejs nodejs-dev node-gyp libssl1.0-dev npm
echo -e "\n\r***********************************";
echo "*    Installing NPM Components              *";
echo -e "\n\r***********************************";

sudo apt-get install nodejs nodejs-dev node-gyp libssl1.0-dev npm

npm config set https-proxy http://${uname}:${pword}@${prox}:${port}--global
npm config set https-proxy http://${uname}:${pword}@${prox}:${port}

npm config set proxy http://${uname}:${pword}@${prox}:${port}--global
npm config set proxy http://${uname}:${pword}@${prox}:${port}

npm config set registry http://registry.npmjs.org
npm config set strict-ssl false
echo "*******************************************************"
echo "* Listing down presently available NPM configurations *"
echo "*******************************************************"
npm config list


apt-get -y install build-essential nghttp2 libnghttp2-dev libssl-dev
mkdir -p /home/KOB 
cd /home/KOB


#KOB-Von
read -p "Do you want to build KOB-Von instance in your system?" reply
	if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
	then
		git clone https://github.com/hyperledgerkochi/von-network.git
		/home/KOB/von-network/manage rm 
		/home/KOB/von-network/manage build
	fi
#KOB-OrgBook
read -p "Do you want to setup KOB instance in your system?" reply
	if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
	then


        	git clone https://github.com/hyperledgerkochi/TheOrgBook.git
        	wget https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
        	tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
        	mv s2i sti /usr/local/bin/
        	/home/KOB/TheOrgBook/docker/manage rm 
		/home/KOB/TheOrgBook/docker/manage build 
	fi

#KOB-DFlow
read -p "Do you want to setup GreenLight instance in your system?" reply
	if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
	then

		git clone https://github.com/hyperledgerkochi/greenlight.git	
        	wget https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
        	tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
        	mv s2i sti /usr/local/bin/
        	/home/KOB/greenlight/docker/manage rm 
		/home/KOB/greenlight/docker/manage build 

	fi



read -p "KOB -Start (y/n)" reply
if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
then
	/home/KOB
	/home/KOB/von-network/manage start
	/home/KOB/TheOrgBook/docker/manage start seed=the_org_book_0000000000000000000	
	/home/KOB/greenlight/docker/manage start 
fi

	echo -e "\n\n\r\r*****************";
	echo " Try to use the listed links and confirm the health status of Von Netowrk";

	echo -e "\n\n\r\r*****************";
	echo -e "*****************";
	echo "Von Network project Links to check Web Console Status(Copy/paste on your web-browser and confirm the status)"
	echo -e "*****************";
	echo -e "\n\n\r\r*****************";

	echo "********************"
	echo "                    "
	#firefox https://localhost:9000/
	echo -e "\n\r"
	echo -e "\n\n\r\r*****************";
	echo -e "*****************";
	echo "KOB- project Links to check Web Console Status(Copy/paste on your web-browser and confirm the status)"
	echo -e "*****************";
	echo -e "\n\n\r\r*****************";
 	echo "********************"
	#firefox http://localhost:8080/
        #firefox http://localhost:8081/
        #firefox http://localhost:8082/
        #firefox http://localhost:8983/
        echo "                    "
	echo -e "*****************";
	echo -e "\n\n\r\r*****************";
 	echo "********************"
