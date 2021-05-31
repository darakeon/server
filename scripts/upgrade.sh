#!/bin/sh

./print-date.sh start upgrade

cd /home/ubuntu/server

git pull

cd scripts

cat crontab | crontab -

./print-date.sh end upgrade

./compose.sh sites
./cleanup.sh
