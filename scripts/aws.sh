#!/bin/bash
set -e

sudo apt-get install -y unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip
rm -r aws

if [ ! -e ~/.aws ]; then
    mkdir ~/.aws
fi

if [ ! -e ~/.aws/config ]; then
    echo "[default]" > ~/.aws/config
    echo "region = us-west-2" >> ~/.aws/config
    echo "output = json" >> ~/.aws/config
fi

if [ ! -e ~/.aws/credentials ]; then \
    echo "[default]" > ~/.aws/credentials; \
    echo "aws_access_key_id = " >> ~/.aws/credentials; \
    echo "aws_secret_access_key = " >> ~/.aws/credentials; \
    nano ~/.aws/credentials; \
fi

sudo bash -c 'echo "AWS_LAMBDA_NAME=" >> /etc/environment'
sudo nano /etc/environment
