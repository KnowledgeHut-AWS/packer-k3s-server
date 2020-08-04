#!/bin/bash
sudo apt update -y && sudo apt install -y curl vim jq git make docker.io
sudo usermod -aG docker ubuntu
curl -sfL https://get.k3s.io | sh -
sudo systemctl enable k3s
sudo systemctl start k3s
sleep 5
sudo cat /var/lib/rancher/k3s/server/token
sudo cp /var/lib/rancher/k3s/server/token /home/ubuntu/token
sudo chmod a+rw /home/ubuntu/token
sudo chown ubuntu:ubuntu /home/ubuntu/token
sudo chmod a+r /etc/rancher/k3s/k3s.yaml
kubectl taint node $(hostname) k3s-controlplane=true:NoSchedule
