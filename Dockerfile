FROM centos:latest
COPY entry.sh /entry.sh
COPY pdns41_db.sql ./pdns_db.sql
RUN dnf check-update ; \
    dnf update -y

RUN dnf install epel-release -y && \
    dnf install pdns pdns-backend-sqlite sqlite -y && \
    dnf clean all && \
    chmod +x /*.sh
EXPOSE 53
ENTRYPOINT ["/entry.sh"]
CMD ["pdns_server", "--daemon=no"]
