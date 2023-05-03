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
echo "Disabling Swap..."

swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo "Setting kernel..."

echo "Setting kernel..."

tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sysctl --system

echo "Setting Containerd..."

containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
systemctl restart containerd
systemctl enable containerd

echo "Kubernetes configured."