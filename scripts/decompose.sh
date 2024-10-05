#!/bin/bash

PROJ=$1

./print-date.sh start decompose $PROJ

docker compose -p $PROJ -f ../docker/compose/$PROJ.yml down

./print-date.sh end decompose $PROJ
