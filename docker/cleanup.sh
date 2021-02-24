echo --------------------------------------------------------------------------------
echo BEFORE
df --output=source,size,pcent -h | grep /dev/root
echo --------------------------------------------------------------------------------

docker container prune -f > /dev/null
docker image prune -f -a > /dev/null
docker network prune -f > /dev/null
docker image prune -f > /dev/null
docker system prune -f > /dev/null

echo --------------------------------------------------------------------------------
echo AFTER
df --output=source,size,pcent -h | grep /dev/root
echo --------------------------------------------------------------------------------
