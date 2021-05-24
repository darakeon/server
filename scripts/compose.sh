#!/bin/sh

docker-compose -f ../docker/compose/$1.yml pull --ignore-pull-failures

export TASK=$2
docker-compose -f ../docker/compose/$1.yml up -d --remove-orphans
