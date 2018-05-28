FROM debian:stretch

LABEL MAINTAINER=ysicing

ENV TZ=Asia/Shanghai

ADD percona-release.list /etc/apt/sources.list.d/percona-release.list 

COPY gpg /etc/apt/trusted.gpg.d/

RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends vim curl tree procps ca-certificates ftp percona-xtrabackup-24 \
    && curl -SL https://github.com/odise/go-cron/releases/download/v0.0.7/go-cron-linux.gz | zcat > /usr/local/bin/go-cron \
    && curl -L https://dl.minio.io/client/mc/release/linux-amd64/mc -o  /usr/local/bin/mc \
    && chmod u+x  /usr/local/bin/go-cron /usr/local/bin/mc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* 

ENTRYPOINT ["/usr/bin/xtrabackup"]

CMD ["--version"]