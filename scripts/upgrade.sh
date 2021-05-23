#!/bin/sh

cd /home/ubuntu/server

git pull

cd scripts

cat crontab | crontab -

./compose.sh sites
./cleanup.sh
