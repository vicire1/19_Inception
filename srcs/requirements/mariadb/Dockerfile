FROM debian:bookworm
RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install mariadb-server -y
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/init_db.sh /usr/local/bin/init_db.sh
RUN chmod 755 /usr/local/bin/init_db.sh
EXPOSE 3306
ENTRYPOINT ["/usr/local/bin/init_db.sh"]
