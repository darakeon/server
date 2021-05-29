#!/bin/sh

PROJ=$1
export TASK=$2

docker-compose -p $PROJ -f ../docker/compose/$PROJ.yml pull --ignore-pull-failures
docker-compose -p $PROJ -f ../docker/compose/$PROJ.yml up -d --remove-orphans
