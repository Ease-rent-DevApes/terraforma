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

echo "Initiating Kubernetes Server..."

kubeadm init --control-plane-endpoint $(hostname -i)

echo "Setting access..."

export KUBECONFIG=/etc/kubernetes/admin.conf

mkdir -p $HOME/.kube
cat /etc/kubernetes/admin.conf > $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

echo "Installing Cloud Weave..."

kubectl apply -f "https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s-1.11.yaml"

echo "Fixing taint..."

kubectl taint nodes --all node-role.kubernetes.io/control-plane-
kubectl taint nodes --all node-role.kubernetes.io/master-

systemctl restart kubelet

echo "Kubernetes restarted."