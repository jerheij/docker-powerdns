FROM centos:latest
COPY entry.sh /entry.sh
COPY pdns41_db.sql ./pdns_db.sql
RUN sed -i 's~enabled=1~enabled=0~g' /etc/yum/pluginconf.d/fastestmirror.conf && \
    rm -f /var/cache/yum/timedhosts.txt && \
    yum check-update && \
    yum update -y

RUN yum install epel-release -y && \
    yum install pdns pdns-backend-sqlite -y && \
    yum clean all && \
    chmod +x /*.sh
EXPOSE 53
ENTRYPOINT ["/entry.sh"]
CMD ["pdns_server", "--daemon=no"]
