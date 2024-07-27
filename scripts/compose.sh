#!/bin/sh

PROJ=$1

./print-date.sh start compose $PROJ

docker compose -p $PROJ -f ../docker/compose/$PROJ.yml pull --ignore-pull-failures
docker compose -p $PROJ -f ../docker/compose/$PROJ.yml up -d --remove-orphans

./print-date.sh end compose $PROJ
