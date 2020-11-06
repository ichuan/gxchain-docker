FROM ubuntu:18.04

WORKDIR /opt
VOLUME /opt/coin
# Node, Wallet
EXPOSE 8090 8091

RUN apt-get update && apt-get install -y wget libidn11 librtmp1 libssl1.0.0 libgssapi-krb5-2 libldap-2.4-2 netcat libcurl3 libcurl-openssl1.0-dev

RUN wget https://github.com/gxchain/gxb-core/releases/download/v1.0.200327/gxb_1.0.200327-ubuntu-14.04.tar.gz -O - | tar xzf -

RUN rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh ./logging.ini ./config.ini /opt/
RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
