echo "                                                                                          "
echo "                                                                                          "
echo "                                        ..:::::..                                         "
echo "                                    -==-.       .::::::.                                  "
echo "                                   +.  .:::::::::::..::=++-                               "
echo "                                  +.                       =.                             "
echo "                                 =.                         +     .:..:=-                 "
echo "                                 =                          =:-:.. . :*-                  "
echo "                                +     #=++                 .: :.   .==                    "
echo "                               .=  -#*+.+++:            ...  .....-=.                     "
echo "                               +   -=%-++-#            :: .  ..:=+.                       "
echo "                             .*.    :=-=:            .-. ..:--=:+@*                       "
echo "                           :-=-=---.                .: .=--: :: .@@-                      "
echo "                        :*#=-:  :::-----::::::......*=++-:::-* +@@+                       "
echo "                       =@*    ::::..::::::::::::-------:.:.:##@@+.                        "
echo "                       +@#         .:::::::::::::::::::-+*%@@%=                           "
echo "                        *@%=:               .::---=*#%@%#+=*.                             "
echo "                          -*%@@%#####%%%@@@@@@%##@@@@=     -:                             "
echo "                            +@@%=-----:::..    =@@@@+ -     +.                            "
echo "                           =*@@@=: :     :. :*@@@@@* -       *                            "
echo "                          =-:%++::*.-   :.-: -@%%@# -:      .+                            "
echo "                          + ::=::--=    -*=--+*=#+.-    .:.=*+:                           "
echo "                          =-  :.  .: = :=-::--:-:-.  .-*:#=   =:                          "
echo "                           .+.      #@#       -:  :--#=-+=   .+                           "
echo "                             =*:   ++=*.      .--=*  ++*.  :=:                            "
echo "                              +.=--.     ::--%+  .*= *+. :=:                              "
echo "                              + =: ::---.    +*  :-+=#..=:                                "
echo "                              *-*:     .=    =-- =.#%.+-                                  "
echo "                              =%-: +%.:=--   =:=.+.*==                                    "
echo "                               *=+.=.*#: -.  =-++=%*.                                     "
echo "                                *=-= -@.  +  +-%#@+                                       "
echo "                                 +%*  %:  =  *:%@-                                        "
echo "                                  =@: ==  =.=.#@-                                         "
echo "                                   +% .*  -+=#@=                                          "
echo "                                    %# %  -%#@+                                           "
echo "                                    +@#%  =@@%                                            "
echo "                                    :@@@. #@@+                                            "
echo "                                     +@@%#@@%                                             "
echo "                                      *@@@@@.                                             "
echo "                                       %@@@=                                              "
echo "                                       .@@@                                               "
echo "                                        :@+                                               "
echo "                                         @.                                               "
echo "                                         *                                                "
echo " ========================   E A S E .  R E N T  DevOps Script    ========================="

#!/bin/bash

# Import MongoDB GPG Key
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -

# Create MongoDB list file
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list

# Reload the package database
sudo apt-get update

# Install MongoDB
sudo apt-get install -y mongodb-org

# Start MongoDB Service
sudo systemctl start mongod

# Enable MongoDB to start on boot
sudo systemctl enable mongod

# Check MongoDB status
sudo systemctl status mongod