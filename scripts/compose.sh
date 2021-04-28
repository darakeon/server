#!/bin/sh

docker-compose -f ../docker/compose/$1.yml pull --ignore-pull-failures
docker-compose -f ../docker/compose/$1.yml up -d
