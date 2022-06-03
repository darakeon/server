PUSH=$1

./single.sh alpine . $PUSH
./single.sh ubuntu . $PUSH
./single.sh netcore . $PUSH
./single.sh server ../.. $PUSH
