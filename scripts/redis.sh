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

kubectl create ns redis-cc

kubectl apply -n redis-cc -f deploy/bitnami/redis/cert.yaml

kubectl get cert -n redis-cc

export REDIS_PASSWORD=$((echo "@" && (openssl rand -base64 64 | tr -d '\n' | tr -d '==') && echo "@") | tr -d "[:space:]")

helm install redis-cc --namespace redis-cc --create-namespace
-f deploy/bitnami/redis/redis.yaml
--set auth.password=$REDIS_PASSWORD
bitnami/redis