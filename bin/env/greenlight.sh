#!/bin/bash 



sudo echo "                                                                                                  lllllll   iiii                     hhhhhhh                     tttt"          
sudo echo "                                                                                                  l:::::l  i::::i                    h:::::h                  ttt:::t "         
sudo echo "                                                                                                  l:::::l   iiii                     h:::::h                  t:::::t          "
sudo echo "                                                                                                  l:::::l                            h:::::h                  t:::::t          "
sudo echo "   ggggggggg   gggggrrrrr   rrrrrrrrr       eeeeeeeeeeee        eeeeeeeeeeee    nnnn  nnnnnnnn     l::::l iiiiiii    ggggggggg   gggggh::::h hhhhh      ttttttt:::::ttttttt    "
sudo echo "  g:::::::::ggg::::gr::::rrr:::::::::r    ee::::::::::::ee    ee::::::::::::ee  n:::nn::::::::nn   l::::l i:::::i   g:::::::::ggg::::gh::::hh:::::hhh   t:::::::::::::::::t    "
sudo echo " g:::::::::::::::::gr:::::::::::::::::r  e::::::eeeee:::::ee e::::::eeeee:::::een::::::::::::::nn  l::::l  i::::i  g:::::::::::::::::gh::::::::::::::hh t:::::::::::::::::t    "
sudo echo "g::::::ggggg::::::ggrr::::::rrrrr::::::re::::::e     e:::::ee::::::e     e:::::enn:::::::::::::::n l::::l  i::::i g::::::ggggg::::::ggh:::::::hhh::::::htttttt:::::::tttttt    "
sudo echo "g:::::g     g:::::g  r:::::r     r:::::re:::::::eeeee::::::ee:::::::eeeee::::::e  n:::::nnnn:::::n l::::l  i::::i g:::::g     g:::::g h::::::h   h::::::h     t:::::t          "
sudo echo "g:::::g     g:::::g  r:::::r     rrrrrrre:::::::::::::::::e e:::::::::::::::::e   n::::n    n::::n l::::l  i::::i g:::::g     g:::::g h:::::h     h:::::h     t:::::t          "
sudo echo "g:::::g     g:::::g  r:::::r            e::::::eeeeeeeeeee  e::::::eeeeeeeeeee    n::::n    n::::n l::::l  i::::i g:::::g     g:::::g h:::::h     h:::::h     t:::::t          "
sudo echo "g::::::g    g:::::g  r:::::r            e:::::::e           e:::::::e             n::::n    n::::n l::::l  i::::i g::::::g    g:::::g h:::::h     h:::::h     t:::::t    tttttt"
sudo echo "g:::::::ggggg:::::g  r:::::r            e::::::::e          e::::::::e            n::::n    n::::nl::::::li::::::ig:::::::ggggg:::::g h:::::h     h:::::h     t::::::tttt:::::t"
sudo echo " g::::::::::::::::g  r:::::r             e::::::::eeeeeeee   e::::::::eeeeeeee    n::::n    n::::nl::::::li::::::i g::::::::::::::::g h:::::h     h:::::h     tt::::::::::::::t"
sudo echo "  gg::::::::::::::g  r:::::r              ee:::::::::::::e    ee:::::::::::::e    n::::n    n::::nl::::::li::::::i  gg::::::::::::::g h:::::h     h:::::h       tt:::::::::::tt"
sudo echo "    gggggggg::::::g  rrrrrrr                eeeeeeeeeeeeee      eeeeeeeeeeeeee    nnnnnn    nnnnnnlllllllliiiiiiii    gggggggg::::::g hhhhhhh     hhhhhhh         ttttttttttt  "
sudo echo "            g:::::g                                                                                                           g:::::g                                          "
sudo echo "gggggg      g:::::g                                                                                               gggggg      g:::::g                                          "
sudo echo "g:::::gg   gg:::::g                                                                                               g:::::gg   gg:::::g                                          "
sudo echo " g::::::ggg:::::::g                                                                                                g::::::ggg:::::::g                                          "
sudo echo "  gg:::::::::::::g                                                                                                  gg:::::::::::::g                                           "
sudo echo "    ggg::::::ggg                                                                                                      ggg::::::ggg                                             "
sudo echo "       gggggg                                                                                                            gggggg                                                "


export TOB_dir=/usr/bin/env/tob


Function_greenlight_build()
{
                sudo echo "Build greenlight instance in your system"

                sudo git clone https://github.com/bcgov/greenlight.git
                sudo wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo mv s2i sti /usr/local/bin/
                sudo /home/TOB/greenlight/docker/manage rm
                sudo /home/TOB/greenlight/docker/manage build



}

fun_greenlight_start()
{
        sudo read -p "Start KOBDflow instance in your system?" reply
        if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
        then
                sudo /home/TOB/greenlight/docker/manage start
        fi
}


