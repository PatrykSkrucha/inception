FROM debian:bullseye-slim

RUN	apt-get update && apt-get upgrade -y  && \
	apt-get clean && \
	apt install vsftpd -y

COPY conf/vsftpd.conf /tmp/vsftpd.conf

COPY tools/init.sh /tmp/init.sh

RUN chmod +x /tmp/init.sh

ENTRYPOINT ["/tmp/init.sh"]

EXPOSE 21

CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]