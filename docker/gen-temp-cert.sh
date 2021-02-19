DIVISION=$1
DOMAIN=$2

openssl genrsa -des3 -passout pass:temporary -out $DOMAIN.pass.key 4096
openssl rsa -passin pass:temporary -in $DOMAIN.pass.key -out $DOMAIN.key
rm $DOMAIN.pass.key
openssl req -new -key $DOMAIN.key -out $DOMAIN.csr -subj "/C=BR/ST=Sao Paulo/L=Poa/O=Keon/OU=$DIVISION/CN=$DOMAIN"
openssl x509 -req -sha256 -days 365 -in $DOMAIN.csr -signkey $DOMAIN.key -out $DOMAIN.crt
mkdir /var/cert
mv $DOMAIN.crt /var/cert/$DOMAIN.crt
mv $DOMAIN.key /var/cert/$DOMAIN.key
