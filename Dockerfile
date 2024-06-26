FROM oraclelinux:8

COPY entry.sh /entry.sh
COPY pdns41_db.sql ./pdns_db.sql

RUN dnf check-update ; \
    dnf update -y && \
    dnf install oracle-epel-release-el8 -y && \
    dnf install pdns pdns-backend-sqlite sqlite -y && \
    dnf clean all && \
    chmod +x /*.sh && \
    chown -R pdns: /var/lib/pdns && \
    chmod -R 750 /var/lib/pdns

EXPOSE 53

ENTRYPOINT ["/entry.sh"]

CMD ["pdns_server", "--daemon=no"]
