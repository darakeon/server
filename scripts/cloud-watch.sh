#!/bin/bash
set -e

set -a
source /var/cfg/cloud-watch/.env
set +a

LOG_MSG="$(cat | tr -d '\r')"

TS=$(date +%s%3N)

aws logs create-log-stream \
	--region "$LOGS_REGION" \
	--log-group-name "$LOGS_GROUP" \
	--log-stream-name "cron-$1" 2>/dev/null || true

aws logs put-log-events \
	--region "$LOGS_REGION" \
	--log-group-name "$LOGS_GROUP" \
	--log-stream-name "cron-$1" \
	--log-events timestamp=$TS,message="$LOG_MSG" \
	>/dev/null 2>&1
