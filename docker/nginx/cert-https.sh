sed -i 's/your-domain/'$2'/g' /etc/nginx/conf.d/default.conf
sed -i 's/your-domain/'$2'/g' /var/cert/cert-lets-encrypt.sh
sed -i 's/your-mail/'$3'/g' /var/cert/cert-lets-encrypt.sh
