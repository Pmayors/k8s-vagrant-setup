#!/bin/bash
set -eux # Exit on error; print commands

echo "[TASK 1] Update apt repo and install prerequisite packages"
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl

echo "[TASK 2] Disable swap"
sudo swapoff -a
# And disable swap on boot
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo "[TASK 3] Enable kernel modules"
sudo modprobe overlay
sudo modprobe br_netfilter

echo "[TASK 4] Add kernel settings for Kubernetes"
cat <<EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

echo "[TASK 5] Apply sysctl settings"
sudo sysctl --system

echo "[TASK 6] Install containerd"
sudo apt-get install -y containerd
# Create default config
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
# Set cgroupdriver to systemd
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
# Restart containerd
sudo systemctl restart containerd

echo "[TASK 7] Add Kubernetes apt repository"
# Download the Google Cloud public signing key
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
# Add the Kubernetes apt repository
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "[TASK 8] Install kubelet, kubeadm, and kubectl"
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
# Hold packages to prevent accidental upgrades
sudo apt-mark hold kubelet kubeadm kubectl

echo "[TASK 9] Enable and start kubelet"
sudo systemctl enable kubelet
sudo systemctl start kubelet

echo "All provisioning steps completed successfully!"
