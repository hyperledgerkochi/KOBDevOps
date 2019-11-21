#!/bin/bash



                                                                                                                                   

echo "  _    ______  _   __    __________  ____ "
echo " | |  / / __ \/ | / /   /_  __/ __ \/ __ )"
echo " | | / / / / /  |/ /_____/ / / / / / __  |"
echo " | |/ / /_/ / /|  /_____/ / / /_/ / /_/ / "
echo " |___/\____/_/ |_/     /_/  \____/_____/  "





Function_VonBuild()
{
                cd /home/TOB/
                sudo echo "Build TOB-Von instance in your system"
                sudo git clone https://github.com/hyperledgerkochi/von-network.git
                sudo /home/TOB/von-network/manage rm
                sudo /home/TOB/von-network/manage build

}

Function_VonStart()
{
        sudo /home/KOB/von-network/manage start
}



