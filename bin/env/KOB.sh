#!/bin/bash

 
                                                          
sudo echo "KKKKKKKKK    KKKKKKK     OOOOOOOOO     BBBBBBBBBBBBBBBBB      " 
sudo echo "K:::::::K    K:::::K   OO:::::::::OO   B::::::::::::::::B     "  
sudo echo "K:::::::K    K:::::K OO:::::::::::::OO B::::::BBBBBB:::::B    "
sudo echo "K:::::::K   K::::::KO:::::::OOO:::::::OBB:::::B     B:::::B   "
sudo echo "KK::::::K  K:::::KKKO::::::O   O::::::O  B::::B     B:::::B   "
sudo echo "  K:::::K K:::::K   O:::::O     O:::::O  B::::B     B:::::B   "
sudo echo "  K::::::K:::::K    O:::::O     O:::::O  B::::BBBBBB:::::B    "
sudo echo "  K:::::::::::K     O:::::O     O:::::O  B:::::::::::::BB     "
sudo echo " K:::::::::::K     O:::::O     O:::::O  B::::BBBBBB:::::B     "
sudo echo " K::::::K:::::K    O:::::O     O:::::O  B::::B     B:::::B    "
sudo echo " K:::::K K:::::K   O:::::O     O:::::O  B::::B     B:::::B    "
sudo echo "KK::::::K  K:::::KKKO::::::O   O::::::O  B::::B     B:::::B   "
sudo echo "K:::::::K   K::::::KO:::::::OOO:::::::OBB:::::BBBBBB::::::B   "
sudo echo "K:::::::K    K:::::K OO:::::::::::::OO B:::::::::::::::::B    "
sudo echo "K:::::::K    K:::::K   OO:::::::::OO   B::::::::::::::::B     "
sudo echo "KKKKKKKKK    KKKKKKK     OOOOOOOOO     BBBBBBBBBBBBBBBBB      "



Function_KobBuild()
{
                sudo echo "Setting-up KOB instance in your system?"
                sudo git clone https://github.com/EtricKombat/TheOrgBook.git
                sudo wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo mv s2i sti /usr/local/bin/
                sudo /home/KOB/TheOrgBook/docker/manage rm
                sudo /home/KOB/TheOrgBook/docker/manage build
                sudo sed -i -e 's/- 3000/- 3100/g' /home/KOB/TheOrgBook/docker/docker-compose.yml


}

Function_KobStart()
{
sudo read -p "Do you want to start KOB instance in your system?" reply
        if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
        then
        sudo /home/KOB/TheOrgBook/docker/manage start seed=the_org_book_0000000000000000000
        fi
}

