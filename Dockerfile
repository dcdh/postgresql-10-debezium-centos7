FROM centos/postgresql-10-centos7

USER root

RUN yum -y install git make gcc rh-postgresql10-postgresql-devel \
    && yum clean all

ENV PATH="/opt/rh/rh-postgresql10/root/usr/bin:${PATH}"
ENV LD_LIBRARY_PATH="/opt/rh/rh-postgresql10/root/usr/lib64:${LD_LIBRARY_PATH}"

RUN git clone https://github.com/eulerto/wal2json -b master --single-branch \
    && cd wal2json \
    && git checkout d2b7fef021c46e0d429f2c1768de361069e58696 \
    && make && make install \
    && cd .. \
    && rm -rf wal2json

COPY debezium.conf /opt/app-root/src/postgresql-cfg/debezium.conf

USER 26
