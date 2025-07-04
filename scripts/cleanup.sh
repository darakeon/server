#!/bin/bash
set -e

echo --------------------------------------------------------------------------------
date
echo BEFORE
df --output=source,size,pcent -h | grep /dev/root
echo --------------------------------------------------------------------------------

#docker container prune -f > /dev/null
docker image prune -f -a > /dev/null
docker network prune -f > /dev/null
#docker system prune -f > /dev/null

echo --------------------------------------------------------------------------------
date
echo AFTER
df --output=source,size,pcent -h | grep /dev/root
echo --------------------------------------------------------------------------------
