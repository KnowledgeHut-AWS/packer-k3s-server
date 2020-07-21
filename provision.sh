#!/bin/bash
sudo apt update -y && sudo apt install -y curl vim jq git make
curl -Ls get.docker.com | sh
sudo usermod -aG docker ubuntu
curl -sfL https://get.k3s.io | sh -
mkdir -p /var/lib/rancher/k3s/server

TS=/etc/systemd/system/tokenServer.service
sudo touch $TS
sudo chmod a+rw $TS
cat << EOF > $TS
[Unit]
Description=K3S Token Server on port 8765

[Service]
ExecStart=docker run --name token-server -p 8765:80 --restart=always -v /var/lib/rancher/k3s/server:/usr/share/nginx/html:ro -d nginx
ExecStop=docker rm -f token-server

[Install]
WantedBy=multi-user.target
EOF

chmod a+x $TS
sudo systemctl enable tokenServer
sudo systemctl start tokenServer
