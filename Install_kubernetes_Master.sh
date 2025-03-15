#Step 1 : Update and Upgrade Ubuntu
sudo apt-get update
sudo apt-get upgrade
#Step 2 : Disable Swap
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
#Step 3 : Add Kernel Parameters
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter
sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
#Reload the change
sudo sysctl --system
#Step 4 : Install Containerd Runtime
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
#note : you have give timezone
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y containerd.io
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
#Note:Incase systemctl if not work use systemd..
sudo systemctl restart containerd
sudo systemctl enable containerd
#Step 5 : Install Kubernetes Components:
