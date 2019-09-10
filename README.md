[![](https://images.microbadger.com/badges/image/jerheij/powerdns.svg)](https://microbadger.com/images/jerheij/powerdns "Get your own image badge on microbadger.com")
## Simple PowerDNS container with SQLite3 DB

### Sources
Base image: [centos:latest](https://hub.docker.com/_/centos)  
Software: [PowerDNS](https://www.powerdns.com/)

### Requirements:
Working Docker installation.

### Usage

#### Persistence

This PowerDNS uses an SQLite3 database (which is automatically created if it does not detect /pdns.db) as backend which means you need to make sure this database is persistent and not deleted when you delete the container. The database is located at /pdns.db. Start the container the first time and copy the database with the following command:
```
docker cp powerdns:/pdns.db ./pdns.db
```
Àfter this make sure to mount this database file on /pdns.db to keep using it with the following docker parameter:
```
docker run -v pdns.db:/pdns.db
```
You can also mount the database by adding the following file to your docker-compose yaml file:
```
volumes:
  - pdns.db:/pdns.db
```

#### Docker-compose example
```
services:
  pdns:
    image: jerheij/powerdns:latest
    volumes:
      - ./pdns.db:/pdns.db
```

#### Configuration
All the DNS records are saved in the SQLite3 database and can be added on the run by using the following command:
```
docker exec -ti powerdns pdnsutil
```
Read the [pdnsutil documentation](https://doc.powerdns.com/authoritative/manpages/pdnsutil.1.html) for more information about how to use the command.

### Author
Jerheij