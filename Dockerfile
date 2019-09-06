FROM debian
LABEL maintainer="joaquin.polo@gmail.com"

ENV SQUID_VERSION=4.6 \
    SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y squid=${SQUID_VERSION}* \
 && apt-get install -y --no-install-recommends apt-utils \
 && rm -rf /var/lib/apt/lists/*

ADD squid.conf /etc/squid/squid.conf
ADD conf.d /etc/squid/conf.d

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]
