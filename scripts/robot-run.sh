#!/bin/bash
set -e

TASK=$1

./print-date.sh start docker run robot for $TASK

aws lambda invoke \
	--cli-binary-format raw-in-base64-out \
	--function-name $AWS_LAMBDA_NAME \
	--invocation-type Event \
	--payload "\"$TASK\"" \
	response.json

RUN_RESULT=$?

./print-date.sh end docker run robot for $TASK - $RUN_RESULT
