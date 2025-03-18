FROM debian:bookworm
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y nginx && \
	mkdir -p /etc/nginx/ssl && \
	apt-get install -y openssl && \
	openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=Bruxelles/L=Bruxelles/0=42/OU=vdecleir/CN=vdecleir.42.fr" && \
	mkdir -p /var/run/nginx
COPY ./conf/nginx.conf /etc/nginx/conf.d/
RUN chmod 755 /var/www/html && \
	chown -R www-data:www-data /var/www/html
EXPOSE 443
ENTRYPOINT ["nginx", "-g", "daemon off;"]
