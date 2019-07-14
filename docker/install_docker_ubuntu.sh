#!/usr/bin/env bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo -E add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo -E apt-get update
sudo -E apt-get install -y docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -a -G docker $USER
sudo mkdir -p /etc/systemd/system/docker.service.d

sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf > /dev/null <<'EOF'
[Service]
Environment="HTTP_PROXY=http://proxy.ncbs.res.in:3128/"
EOF

sudo tee /etc/systemd/system/docker.service.d/https-proxy.conf > /dev/null <<'EOF'
[Service]
Environment="HTTPS_PROXY=http://proxy.ncbs.res.in:3128/"
EOF
sudo systemctl restart docker
sudo systemctl daemon-reload
