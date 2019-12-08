https://github.com/sclorg/postgresql-container/blob/generated/10/Dockerfile
https://github.com/debezium/docker-images/tree/master/postgres/10

docker build -t dcdh1983/postgresql-10-debezium-centos7 .
docker push dcdh1983/postgresql-10-debezium-centos7:latest
docker pull dcdh1983/postgresql-10-debezium-centos7:latest

docker kill postgres; docker rm postgres; docker run -it --name postgres -e POSTGRESQL_USER=postgresql -e POSTGRESQL_PASSWORD=postgresql -e POSTGRESQL_DATABASE=db -d dcdh1983/postgresql-10-debezium-centos7:latest

docker exec -it postgres bash

psql -U postgres

SHOW ALL

select * from pg_stat_replication;
select * from pg_stat_wal_receiver;

SELECT * FROM pg_roles;

// wanted
          rolname          | rolsuper | rolinherit | rolcreaterole | rolcreatedb | rolcanlogin | rolreplication | rolconnlimit | rolpassword | rolvaliduntil | rolbypassrls | rolconfig | oid  
---------------------------+----------+------------+---------------+-------------+-------------+----------------+--------------+-------------+---------------+--------------+-----------+------
 postgresql                | t        | t          | t             | t           | t           | t              |           -1 | ********    |               | t            |           |   10

show shared_preload_libraries;
 shared_preload_libraries 
--------------------------
 decoderbufs,wal2json

show wal_level;
 wal_level 
-----------
 logical

show max_wal_senders;
 max_wal_senders 
-----------------
 4

show max_replication_slots;
 max_replication_slots 
-----------------------
 4


cat /var/lib/postgresql/data/pg_hba.conf | grep replication
local   replication     all                                     trust
host    replication     all             127.0.0.1/32            trust
host    replication     all             ::1/128                 trust
host replication postgresql 0.0.0.0/0 trust


// current openshift
       rolname        | rolsuper | rolinherit | rolcreaterole | rolcreatedb | rolcanlogin | rolreplication | rolconnlimit | rolpassword | rolvaliduntil | rolbypassrls | rolconfig |  oid
----------------------+----------+------------+---------------+-------------+-------------+----------------+--------------+-------------+---------------+--------------+-----------+-------
 postgresuser         | f        | t          | f             | f           | t           | f              |           -1 | ********    |               | f            |           | 16384

> KO

/home/jenkins/data/userdata/pg_hba.conf

ALTER ROLE $POSTGRESQL_USER REPLICATION LOGIN;