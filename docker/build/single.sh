DIR=$(dirname $0)
MACHINE=$1

if [ "$MACHINE" == "" ]; then
	echo "missing machine name"
	exit 1
fi

CONTEXT=$2
PUSH=$3

if [ "$CONTEXT" == "" ]; then
	CONTEXT=.
fi

docker build $CONTEXT --pull -f $DIR/../images/$MACHINE.dockerfile -t darakeon/$MACHINE --network=host

if [ "$PUSH" == "push" ]; then
	docker push darakeon/$MACHINE
fi
