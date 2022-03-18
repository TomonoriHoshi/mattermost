docker:
  sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io
  
docker-user:
  sudo usermod -aG docker $(shell whoami)
  sudo systemctl restart docker
  exit

docker-compose:
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$$(uname -s)-$$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version

mattermost:
  sudo apt install -y git
  git clone https://github.com/mattermost/mattermost-docker.git
  cd ../mattermost-docker && docker-compose build
  @echo "mkdir -pv ./volumes/app/mattermost/{data,logs,config,plugins,client-plugins}"
  @echo "sudo chown -R 1000:1000 ./volumes/app/mattermost/"
  @echo "docker-compose up -d"