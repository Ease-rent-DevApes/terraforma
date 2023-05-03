bash /home/$USER/scripts/initialsetup.sh && \
bash /home/$USER/install/docker.sh && \
bash /home/$USER/install/kube.sh && \
bash /home/$USER/install/kube-config.sh && \
bash /home/$USER/install/kube-master.sh && \
bash /home/$USER/install/helm.sh


export KUBECONFIG=/etc/kubernetes/admin.conf

kubectl get nodes

export HOST=spike
export USER=spike

export HOST=faye
export USER=faye

rm -rf apps
mkdir apps
chmod 777 apps

rm -rf deploy
mkdir deploy
chmod 777 deploy

rm -rf install
mkdir install
chmod 777 install

sftp -oPort=2222 $USER@127.0.1.1

put -r apps apps
put -r deploy deploy
put -r install install

gcloud compute scp --recurse apps/* $USER@$HOST:/home/$USER/apps

gcloud compute scp --recurse deploy/* $USER@$HOST:/home/$USER/deploy

gcloud compute scp --recurse install/* $USER@$HOST:/home/$USER/install

echo "@" && (openssl rand -base64 64 | tr -d '\n' | tr -d '==') && echo "@" | pbcopy