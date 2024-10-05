#!/bin/bash
set -e

cd ~
git clone https://github.com/darakeon/server.git

cd ~/server/scripts
./docker.sh
./aws.sh

echo 'export PS1="\n\n[\[\033[01;30m\]\A\[\033[00m\]] 🐳 \$(docker ps -q | wc -l)/\$(docker ps -a -q | wc -l) \[\033[01;31m\]\u\[\033[00m\]@\[\033[01;35m\]\`if [[ \$PWD = /mnt/c* ]]; then echo \"#\"; else echo \"&\"; fi\`/\W\[\033[00m\]$ "' >> ~/.bashrc

sudo cp ~/server/docker/images/scripts/ubuntu_maintain /usr/bin/maintain
sudo chmod +x /usr/bin/maintain

cd ~/server/scripts

sudo ./config.sh

sudo mkdir /var/log/cron
sudo chmod 777 /var/log/cron

./upgrade.sh
