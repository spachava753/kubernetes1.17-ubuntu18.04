# Pull images form gcr.io registry
sudo kubeadm config images pull

# Pod cidr is for Calico and apiserver is the address that we assigned
sudo kubeadm init --apiserver-advertise-address=192.168.50.10 --pod-network-cidr=192.168.0.0/16 --cri-socket=/var/run/containerd/containerd.sock

sudo kubeadm token create --print-join-command > /synced_folder/joincluster.sh
chmod +x /synced_folder/joincluster.sh

sudo cp -i /etc/kubernetes/admin.conf /synced_folder/config

sudo kubectl --kubeconfig /etc/kubernetes/admin.conf apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml 
