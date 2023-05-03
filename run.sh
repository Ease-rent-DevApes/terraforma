bash /home/$USER/scripts/initialsetup.sh && \
bash /home/$USER/install/docker.sh && \
bash /home/$USER/install/kube.sh && \
bash /home/$USER/install/kube-config.sh && \
bash /home/$USER/install/kube-master.sh && \
bash /home/$USER/install/helm.sh


export KUBECONFIG=/etc/kubernetes/admin.conf

kubectl get nodes