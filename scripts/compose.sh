#!/bin/bash
set -e

PROJ=$1

./print-date.sh start compose $PROJ

docker compose -p $PROJ -f ../docker/compose/$PROJ.yml pull --ignore-pull-failures
docker compose -p $PROJ -f ../docker/compose/$PROJ.yml up -d --remove-orphans

UP_RESULT=$?

./print-date.sh end compose $PROJ

if [ $UP_RESULT != 0 ]; then
    ./decompose.sh $PROJ
fi
