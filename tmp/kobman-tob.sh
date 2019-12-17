#!/bin/bash 
                                                              
                                                              


function __kobman_tob_build
{
           

		figlet Building TheOrgBook
		cd ${KOBMAN_CANDIDATES_DIR}
         	sudo echo "Setting-up TOB instance in your system?"
                sudo git clone https://github.com/bcgov/TheOrgBook.git
                sudo wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo mv s2i sti /usr/local/bin/
                sudo TheOrgBook/docker/manage rm
                sudo TheOrgBook/docker/manage build
                sudo sed -i -e 's/- 3000/- 3100/g' TheOrgBook/docker/docker-compose.yml


}

function __kobman_tob_start
{



	figlet starting TheOrgBook
	cd ${KOBMAN_CANDIDATES_DIR}
	sudo read -p "Do you want to start TOB instance in your system?" reply
        if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
        then
        sudo TheOrgBook/docker/manage start seed=the_org_book_0000000000000000000
        fi
}

function __kobman_tob_uninstall
{
	figlet Removing TheOrgBook
	cd ${KOBMAN_CANDIDATES_DIR}
	sudo TheOrgBook/docker/manage rm
	sudo rm -rf /usr/local/bin/s2i /usr/local/bin/sti TheOrgBook/	
}	
