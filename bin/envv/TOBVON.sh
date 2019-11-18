#!/bin/bash



                                                                                                                                   
sudo echo "TTTTTTTTTTTTTTTTTTTTTTT     OOOOOOOOO     BBBBBBBBBBBBBBBBB   VVVVVVVV           VVVVVVVV     OOOOOOOOO     NNNNNNNN        NNNNNNNN"
sudo echo "T:::::::::::::::::::::T   OO:::::::::OO   B::::::::::::::::B  V::::::V           V::::::V   OO:::::::::OO   N:::::::N       N::::::N"
sudo echo "T:::::::::::::::::::::T OO:::::::::::::OO B::::::BBBBBB:::::B V::::::V           V::::::V OO:::::::::::::OO N::::::::N      N::::::N"
sudo echo "T:::::TT:::::::TT:::::TO:::::::OOO:::::::OBB:::::B     B:::::BV::::::V           V::::::VO:::::::OOO:::::::ON:::::::::N     N::::::N"
sudo echo "TTTTTT  T:::::T  TTTTTTO::::::O   O::::::O  B::::B     B:::::B V:::::V           V:::::V O::::::O   O::::::ON::::::::::N    N::::::N"
sudo echo "        T:::::T        O:::::O     O:::::O  B::::B     B:::::B  V:::::V         V:::::V  O:::::O     O:::::ON:::::::::::N   N::::::N"
sudo echo "        T:::::T        O:::::O     O:::::O  B::::BBBBBB:::::B    V:::::V       V:::::V   O:::::O     O:::::ON:::::::N::::N  N::::::N"
sudo echo "        T:::::T        O:::::O     O:::::O  B:::::::::::::BB      V:::::V     V:::::V    O:::::O     O:::::ON::::::N N::::N N::::::N"
sudo echo "        T:::::T        O:::::O     O:::::O  B::::BBBBBB:::::B      V:::::V   V:::::V     O:::::O     O:::::ON::::::N  N::::N:::::::N"
sudo echo "        T:::::T        O:::::O     O:::::O  B::::B     B:::::B      V:::::V V:::::V      O:::::O     O:::::ON::::::N   N:::::::::::N"
sudo echo "        T:::::T        O:::::O     O:::::O  B::::B     B:::::B       V:::::V:::::V       O:::::O     O:::::ON::::::N    N::::::::::N"
sudo echo "        T:::::T        O::::::O   O::::::O  B::::B     B:::::B        V:::::::::V        O::::::O   O::::::ON::::::N     N:::::::::N"
sudo echo "      TT:::::::TT      O:::::::OOO:::::::OBB:::::BBBBBB::::::B         V:::::::V         O:::::::OOO:::::::ON::::::N      N::::::::N"
sudo echo "      T:::::::::T       OO:::::::::::::OO B:::::::::::::::::B           V:::::V           OO:::::::::::::OO N::::::N       N:::::::N"
sudo echo "      T:::::::::T         OO:::::::::OO   B::::::::::::::::B             V:::V              OO:::::::::OO   N::::::N        N::::::N"
sudo echo "      TTTTTTTTTTT           OOOOOOOOO     BBBBBBBBBBBBBBBBB               VVV                 OOOOOOOOO     NNNNNNNN         NNNNNNN"



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



