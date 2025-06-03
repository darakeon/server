#!/bin/bash
set -e

apt-get install -y software-properties-common \
    && add-apt-repository ppa:git-core/ppa -y

cd ~
git clone https://github.com/darakeon/server.git

cd ~/server/scripts
./docker.sh
./aws.sh

echo 'export PS1="\n\n[\[\e[01;30m\]\A\[\e[00m\]] 🐳 \$(docker ps -q | wc -l)/\$(docker ps -a -q | wc -l) \[\e[01;31m\]\u\[\e[00m\]@\[\e[01;35m\]\`if [[ \$PWD = /mnt/c* ]]; then echo \"#\"; else echo \"&\"; fi\`/\W\[\e[00m\]$ "' >> ~/.bashrc

sudo cp ~/server/docker/images/scripts/ubuntu_maintain /usr/bin/maintain
sudo chmod +x /usr/bin/maintain

cd ~/server/scripts

sudo ./shortcuts.sh
sudo ./config.sh
sudo ./nat.sh

sudo mkdir /var/log/cron
sudo chmod 777 /var/log/cron

./upgrade.sh
