PUSH=$1

./single.sh ubuntu . $PUSH
./single.sh netcore . $PUSH
./single.sh server ../.. $PUSH

./single.sh talisman . $PUSH

# ./single.sh aws . $PUSH
# ./single.sh aws-terraform . $PUSH
