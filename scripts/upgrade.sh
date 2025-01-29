#!/bin/bash
set -e

./print-date.sh start upgrade

cd ~/server

export DIFF=$(git diff)

if [ "$DIFF" != "" ]; then
    git stash
fi

git pull

if [ "$DIFF" != "" ]; then
    git stash pop
fi

cd scripts

cat crontab | crontab -

./print-date.sh end upgrade

./compose.sh sites
./cleanup.sh
