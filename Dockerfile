FROM ubuntu

MAINTAINER  Sven Krueger "lamagra@lamagra-online.de"

ENV SQUID_USERNAME squid
ENV SQUID_PASSWORD password
ENV SQUID_LOCALNET 10.0.0.0/8
ENV SQUID_CACHE_PEER ""
#ENV SQUID_NEVER_DIRECT "allow all"

ENV CACHE_MAX_SIZE 100
ENV CACHE_MAX_OBJECT_SIZE 4
ENV CACHE_MAX_MEM 256

RUN apt-get update && \
    apt-get install -y squid3 apache2-utils m4 && \
    mv /etc/squid3/squid.conf /etc/squid3/squid.conf.dist && \
	apt-get clean

RUN cd /etc/squid3 && \
	mkdir /etc/squid3/conf.d && \
	curl https://github.com/unnuetz/steam-cache-squid/blob/master/steam_store_id --output steam_store_id && \
	cd /etc/squid3/conf && \
	curl https://github.com/unnuetz/steam-cache-squid/blob/master/squid.acl.conf --output squid.acl.conf && \
	curl https://github.com/unnuetz/steam-cache-squid/blob/master/steam.conf --output steam.conf
		
ADD squid.conf.m4 /etc/squid3/squid.conf.m4
ADD start /start

EXPOSE 3128

VOLUME ["/var/spool/squid3"]

ENTRYPOINT ["/start"]
