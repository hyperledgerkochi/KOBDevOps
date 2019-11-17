#!/bin/bash


                                                                                                                      
sudo echo "KKKKKKKKK    KKKKKKK     OOOOOOOOO     BBBBBBBBBBBBBBBBB   VVVVVVVV           VVVVVVVV                                   "                         
sudo echo "K:::::::K    K:::::K   OO:::::::::OO   B::::::::::::::::B  V::::::V           V::::::V                                   "
sudo echo "K:::::::K    K:::::K OO:::::::::::::OO B::::::BBBBBB:::::B V::::::V           V::::::V                                   "
sudo echo "K:::::::K   K::::::KO:::::::OOO:::::::OBB:::::B     B:::::BV::::::V           V::::::V                                   "
sudo echo "KK::::::K  K:::::KKKO::::::O   O::::::O  B::::B     B:::::B V:::::V           V:::::V ooooooooooo   nnnn  nnnnnnnn       "
sudo echo "  K:::::K K:::::K   O:::::O     O:::::O  B::::B     B:::::B  V:::::V         V:::::Voo:::::::::::oo n:::nn::::::::nn     "
sudo echo "  K::::::K:::::K    O:::::O     O:::::O  B::::BBBBBB:::::B    V:::::V       V:::::Vo:::::::::::::::on::::::::::::::nn    "
sudo echo "  K:::::::::::K     O:::::O     O:::::O  B:::::::::::::BB      V:::::V     V:::::V o:::::ooooo:::::onn:::::::::::::::n   "
sudo echo "  K:::::::::::K     O:::::O     O:::::O  B::::BBBBBB:::::B      V:::::V   V:::::V  o::::o     o::::o  n:::::nnnn:::::n   "
sudo echo "  K::::::K:::::K    O:::::O     O:::::O  B::::B     B:::::B      V:::::V V:::::V   o::::o     o::::o  n::::n    n::::n   "
sudo echo "  K:::::K K:::::K   O:::::O     O:::::O  B::::B     B:::::B       V:::::V:::::V    o::::o     o::::o  n::::n    n::::n   "
sudo echo "KK::::::K  K:::::KKKO::::::O   O::::::O  B::::B     B:::::B        V:::::::::V     o::::o     o::::o  n::::n    n::::n   "
sudo echo "K:::::::K   K::::::KO:::::::OOO:::::::OBB:::::BBBBBB::::::B         V:::::::V      o:::::ooooo:::::o  n::::n    n::::n   "
sudo echo "K:::::::K    K:::::K OO:::::::::::::OO B:::::::::::::::::B           V:::::V       o:::::::::::::::o  n::::n    n::::n   "
sudo echo "K:::::::K    K:::::K   OO:::::::::OO   B::::::::::::::::B             V:::V         oo:::::::::::oo   n::::n    n::::n   "
sudo echo "KKKKKKKKK    KKKKKKK     OOOOOOOOO     BBBBBBBBBBBBBBBBB               VVV            ooooooooooo     nnnnnn    nnnnnn   " 



Function_VonBuild()
{
                cd /home/KOB/
                sudo echo "Build KOB-Von instance in your system"
                sudo git clone https://github.com/hyperledgerkochi/von-network.git
                sudo /home/KOB/von-network/manage rm
                sudo /home/KOB/von-network/manage build

}

Function_VonStart()
{
        sudo /home/KOB/von-network/manage start
}

