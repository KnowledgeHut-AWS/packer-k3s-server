#!/bin/bash
sudo apt update -y && sudo apt install -y curl vim jq git make
curl -Ls get.docker.com | sh
sudo usermod -aG docker ubuntu
sudo docker pull nginx
curl -sfL https://get.k3s.io | sh -
mkdir -p /var/lib/rancher/k3s/server
mkdir -p /home/ubuntu/token
sudo touch /etc/systemd/system/tokenServer.service
sudo chmod a+rw /etc/systemd/system/tokenServer.service

cat << EOF >> /etc/systemd/system/tokenServer.service
[Unit]
Description=K3S Token Server on port 8765
After=k3s.target

[Service]
ExecStartPre=cp /var/lib/rancher/k3s/server/token /home/ubuntu/token/index.html
ExecStartPre=chown ubuntu:ubuntu /home/ubuntu/token/index.html
ExecStartPre=chmod a+rw /home/ubuntu/token/index.html
ExecStart=docker run --name token-server -p 8765:80 --restart=always -v /home/ubuntu/token:/usr/share/nginx/html:ro -d nginx
ExecStop=docker rm -f token-server

[Install]
WantedBy=multi-user.target
EOF

sudo chmod a-w /etc/systemd/system/tokenServer.service
sudo systemctl enable tokenServer
sudo systemctl start tokenServer
