cd docker
./cleanup.sh
cd ..

docker-compose pull --ignore-pull-failures
docker-compose up -d
