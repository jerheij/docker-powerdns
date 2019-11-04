#!/bin/bash

echo
echo "Creating different powerdns configuration files..."
sed -i 's~# include-dir=~include-dir=/etc/pdns/conf.d~g' /etc/pdns/pdns.conf

mkdir /etc/pdns/conf.d
cat <<EOF > /etc/pdns/conf.d/docker.conf

daemon=no
guardian=no
write-pid=no

disable-syslog=yes

local-address=0.0.0.0
local-port=53

tcp-control-address=0.0.0.0
tcp-control-port=53000
tcp-control-range=127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16

webserver=no

version-string=anonymous
# backend
launch=gsqlite3
gsqlite3-database=/var/lib/pdns/pdns.db
gsqlite3-pragma-journal-mode=off
gsqlite3-pragma-synchronous=0
# eo backend
EOF


DBCheck=$(test -f /var/lib/pdns/pdns.db || echo "false")

case $DBCheck in

false)
  echo
  echo "Creating empty database..."
  cat /pdns_db.sql  | sqlite3 /var/lib/pdns/pdns.db
;;

*)
  echo
  echo "Database exists; not doing anything."
;;
esac

echo
echo "Config files:"
find /etc/pdns/

echo
echo "Deployment done!"
exec "$@"
