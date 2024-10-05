#!/bin/bash

TASK=$1

./print-date.sh start docker run robot for $TASK

docker pull darakeon/dfm-robot

docker run \
	--name robot_$TASK \
	-e TASK=$TASK \
	-v /var/cfg/dfm:/var/cfg \
	-v /var/data/dfm/robot-$TASK:/var/robot/data \
	-v /var/data/dfm/nh-$TASK:/var/logs/dfm/nh \
	--rm \
	darakeon/dfm-robot

RUN_RESULT=$?

./print-date.sh end docker run robot for $TASK - $RUN_RESULT
