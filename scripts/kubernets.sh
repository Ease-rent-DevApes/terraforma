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

# Install Docker if it is not already installed
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Installing Docker..."
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
    systemctl enable docker.service
    systemctl start docker.service
    echo "Docker installed successfully."
else
    echo "Docker is already installed."
fi

# Add Kubernetes repository to the system
echo "Adding Kubernetes repository..."
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update

# Install kubelet, kubeadm, kubectl
echo "Installing Kubernetes components..."
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
echo "Kubernetes components installed successfully."

# Enable and start kubelet service
echo "Enabling and starting kubelet service..."
systemctl enable kubelet.service
systemctl start kubelet.service
echo "Kubelet service enabled and started."
