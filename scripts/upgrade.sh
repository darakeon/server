#!/bin/sh

./print-date.sh start upgrade

cd /home/ubuntu/server

git stash

git pull

git stash pop

cd scripts

cat crontab | crontab -

./print-date.sh end upgrade

./compose.sh sites
./cleanup.sh
