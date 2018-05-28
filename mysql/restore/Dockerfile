FROM rainbond/plugins:base-mysql

ADD entrypoint.sh /bin/entrypoint
ADD restore.sh /bin/restore

RUN chmod 755 /bin/entrypoint /bin/restore

ENTRYPOINT ["entrypoint"]