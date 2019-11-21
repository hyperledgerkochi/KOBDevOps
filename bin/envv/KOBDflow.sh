#!/bin/bash 


echo "       __ ______  ____        ____  ______              "
echo "      / //_/ __ \/ __ )      / __ \/ __/ /___ _      __ "
echo "     / ,< / / / / __  |_____/ / / / /_/ / __ \ | /| / / "
echo "    / /| / /_/ / /_/ /_____/ /_/ / __/ / /_/ / |/ |/ /  "
echo "   /_/ |_\____/_____/     /_____/_/ /_/\____/|__/|__/   "




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


