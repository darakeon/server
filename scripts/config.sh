#!/bin/bash
set -e

cd /var
sudo mkdir cfg
cd cfg

mkdir dfm
cd dfm
echo $PWD/db.amazon.json > db.amazon.json && nano db.amazon.json
echo $PWD/smtp.amazon.json > smtp.amazon.json && nano smtp.amazon.json
echo $PWD/s3.amazon.json > s3.amazon.json && nano s3.amazon.json
echo $PWD/sqs.amazon.json > sqs.amazon.json && nano sqs.amazon.json
echo $PWD/login.amazon.json > login.amazon.json && nano login.amazon.json
cd ..

mkdir sql-sunner
sql-sunner
echo $PWD/prod.env > prod.env && nano prod.env
echo $PWD/prod.py > prod.py && nano prod.py
cd ..

mkdir midna
cd midna
echo $PWD/.env > .env && nano .env
cd ..
