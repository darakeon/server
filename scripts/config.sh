#!/bin/bash
set -e

cd /var
if [ ! -e cfg ]; then mkdir cfg; fi
cd cfg

if [ ! -e dfm ]; then mkdir dfm; fi
cd dfm
if [ ! -e db.amazon.json ]; then echo $PWD/db.amazon.json > db.amazon.json && nano db.amazon.json; fi
if [ ! -e smtp.amazon.json ]; then echo $PWD/smtp.amazon.json > smtp.amazon.json && nano smtp.amazon.json; fi
if [ ! -e s3.amazon.json ]; then echo $PWD/s3.amazon.json > s3.amazon.json && nano s3.amazon.json; fi
if [ ! -e sqs.amazon.json ]; then echo $PWD/sqs.amazon.json > sqs.amazon.json && nano sqs.amazon.json; fi
if [ ! -e login.amazon.json ]; then echo $PWD/login.amazon.json > login.amazon.json && nano login.amazon.json; fi
cd ..

if [ ! -e midna ]; then mkdir midna; fi
cd midna
if [ ! -e prod.env ]; then echo $PWD/prod.env > prod.env && nano prod.env; fi
if [ ! -e prod.py ]; then echo $PWD/prod.py > prod.py && nano prod.py; fi
cd ..

if [ ! -e sql-runner ]; then mkdir sql-runner; fi
cd sql-runner
if [ ! -e .env ]; then echo $PWD/.env > .env && nano .env; fi
cd ..

if [ ! -e tls ]; then mkdir tls; fi
cd tls
if [ ! -e .env ]; then echo $PWD/.env > .env && nano .env; fi
cd ..

sudo chmod 777 /var/log
