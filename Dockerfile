FROM ubuntu:14.04

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

ADD	steam_store_id /etc/squid3/steam_store_id 
ADD	squid.acl.conf /etc/squid3/conf.d/squid.acl.conf 
ADD	steam.conf /etc/squid3/conf.d/steam.conf
ADD squid.conf.m4 /etc/squid3/squid.conf.m4
ADD start /start

EXPOSE 3128

VOLUME ["/var/spool/squid3"]

ENTRYPOINT ["/start"]
