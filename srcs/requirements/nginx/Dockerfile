#install nginx and openssl
RUN apk update && apk add nginx openssl

#open and use this port:
EXPOSE 443

#create an ssl folder to store the ssl certiicate
RUN mkdir -p /etc/nginx/ssl

#create the ssl certificate.
RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/public_certificate.crt \
    -keyout /etc/nginx/ssl/private.key \
    -subj "/C=FI/ST=Uusimaa/L=Helsinki/O=42/OU=Hive/CN=mkhlouf.42.fr"

#create user 
RUN adduser -D -H -s /sbin/nologin -g www-data -G www-data www-data


#copy my configration file to nginx conf file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod 644 /etc/nginx/nginx.conf

#start nginx and use this configfile, and let it tun in the foreground
CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]
