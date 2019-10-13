https://github.com/sclorg/postgresql-container/blob/generated/10/Dockerfile

docker build -t dcdh1983/postgresql-10-debezium-centos7 .
docker push dcdh1983/postgresql-10-debezium-centos7:latest
docker pull dcdh1983/postgresql-10-debezium-centos7:latest

docker run -it --name postgres -e POSTGRESQL_USER=postgresql -e POSTGRESQL_PASSWORD=postgresql -e POSTGRESQL_DATABASE=db -d dcdh1983/postgresql-10-debezium-centos7:latest
