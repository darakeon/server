#!/bin/sh

PROJ=$1
export TASK=$2

./print-date.sh start compose $PROJ $TASK

docker-compose -p $PROJ -f ../docker/compose/$PROJ.yml pull --ignore-pull-failures
docker-compose -p $PROJ -f ../docker/compose/$PROJ.yml up -d --remove-orphans

./print-date.sh end compose $PROJ $TASK
