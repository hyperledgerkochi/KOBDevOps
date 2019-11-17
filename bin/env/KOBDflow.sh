#!/bin/bash 
sudo echo "KKKKKKKKK    KKKKKKK     OOOOOOOOO     BBBBBBBBBBBBBBBBB       "                                                                                                                 
sudo echo "K:::::::K    K:::::K   OO:::::::::OO   B::::::::::::::::B      "                                                                                                                 
sudo echo "K:::::::K    K:::::K OO:::::::::::::OO B::::::BBBBBB:::::B     "                                                                                                           
sudo echo "K:::::::K   K::::::KO:::::::OOO:::::::OBB:::::B     B:::::B    "                                                                                                           
sudo echo "KK::::::K  K:::::KKKO::::::O   O::::::O  B::::B     B:::::B    "                                                                                                               
sudo echo "  K:::::K K:::::K   O:::::O     O:::::O  B::::B     B:::::B    "                                                                                                           
sudo echo "  K::::::K:::::K    O:::::O     O:::::O  B::::BBBBBB:::::B     "                                                                                                           
sudo echo "  K:::::::::::K     O:::::O     O:::::O  B:::::::::::::BB      "                                                                                                           
sudo echo "  K:::::::::::K     O:::::O     O:::::O  B::::BBBBBB:::::B     "                                                                                                           
sudo echo "  K::::::K:::::K    O:::::O     O:::::O  B::::B     B:::::B    "                                                                                                           
sudo echo "  K:::::K K:::::K   O:::::O     O:::::O  B::::B     B:::::B    "                                                                                                           
sudo echo "KK::::::K  K:::::KKKO::::::O   O::::::O  B::::B     B:::::B    "                                                                                                           
sudo echo "K:::::::K   K::::::KO:::::::OOO:::::::OBB:::::BBBBBB::::::B    "                                                                                                           
sudo echo "K:::::::K    K:::::K OO:::::::::::::OO B:::::::::::::::::B     "                                                                                                           
sudo echo "K:::::::K    K:::::K   OO:::::::::OO   B::::::::::::::::B      "                                                                                                           
sudo echo "KKKKKKKKK    KKKKKKK     OOOOOOOOO     BBBBBBBBBBBBBBBBB       "                                                                                                           
sudo echo " "
sudo echo"DDDDDDDDDDDDD           ffffffffffffffff  lllllll  "                                                       
sudo echo"D::::::::::::DDD       f::::::::::::::::f l:::::l   "                                                      
sudo echo"D:::::::::::::::DD    f::::::::::::::::::fl:::::l   "                                                      
sudo echo"DDD:::::DDDDD:::::D   f::::::fffffff:::::fl:::::l                                                         "
sudo echo"  D:::::D    D:::::D  f:::::f       ffffff l::::l    ooooooooooo wwwwwww           wwwww           wwwwwww"
sudo echo"  D:::::D     D:::::D f:::::f              l::::l  oo:::::::::::oow:::::w         w:::::w         w:::::w "
sudo echo"  D:::::D     D:::::Df:::::::ffffff        l::::l o:::::::::::::::ow:::::w       w:::::::w       w:::::w  "
sudo echo"  D:::::D     D:::::Df::::::::::::f        l::::l o:::::ooooo:::::o w:::::w     w:::::::::w     w:::::w   "
sudo echo"  D:::::D     D:::::Df::::::::::::f        l::::l o::::o     o::::o  w:::::w   w:::::w:::::w   w:::::w    "
sudo echo"  D:::::D     D:::::Df:::::::ffffff        l::::l o::::o     o::::o   w:::::w w:::::w w:::::w w:::::w     "
sudo echo"  D:::::D     D:::::D f:::::f              l::::l o::::o     o::::o    w:::::w:::::w   w:::::w:::::w      "
sudo echo"  D:::::D    D:::::D  f:::::f              l::::l o::::o     o::::o     w:::::::::w     w:::::::::w       "
sudo echo"DDD:::::DDDDD:::::D  f:::::::f            l::::::lo:::::ooooo:::::o      w:::::::w       w:::::::w        "
sudo echo"D:::::::::::::::DD   f:::::::f            l::::::lo:::::::::::::::o       w:::::w         w:::::w         "
sudo echo"D::::::::::::DDD     f:::::::f            l::::::l oo:::::::::::oo         w:::w           w:::w          "
sudo echo"DDDDDDDDDDDDD        fffffffff            llllllll   ooooooooooo            www             www  "




Function_DflowBuild()
{
                sudo echo "Build KOBDflow instance in your system"

                sudo git clone https://github.com/EtricKombat/greenlight.git
                sudo wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo mv s2i sti /usr/local/bin/
                sudo /home/KOB/greenlight/docker/manage rm
                sudo /home/KOB/greenlight/docker/manage build



}

fun_Dflow_start()
{
        sudo read -p "Start KOBDflow instance in your system?" reply
        if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
        then
                sudo /home/KOB/greenlight/docker/manage start
        fi
}


