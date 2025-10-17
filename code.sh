mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install a network
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

# Run this inside the master node
sudo kubeadm init --apiserver-advertise-address=192.168.56.11 --pod-network-cidr=10.244.0.0/16

#Generate token for worker nodes to join
sudo kubeadm token create --print-join-command

#Joining nodes:
# This should be the NEW command with the 192.168.56.11 IP
sudo kubeadm join 192.168.56.11:6443 --token ...
