cd docker
./cleanup.sh
cd ..

docker pull darakeon/mebrak
docker pull darakeon/dfm
docker pull darakeon/server

docker-compose up -d
