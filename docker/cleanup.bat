@echo off

echo --------------------------------------------------------------------------------
echo BEFORE
wmic LogicalDisk Get SystemName,FreeSpace,Size
echo --------------------------------------------------------------------------------

docker container prune -f > NUL
docker image prune -f -a > NUL
docker network prune -f > NUL
docker system prune -f > NUL

echo --------------------------------------------------------------------------------
echo AFTER
wmic LogicalDisk Get SystemName,FreeSpace,Size
echo --------------------------------------------------------------------------------
