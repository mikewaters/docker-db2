# Base DB2 server docker image

FROM ubuntu:trusty
MAINTAINER mike@anonymoushash.com

ENV HTTP_PROXY http://ProxyServiceAccount:DTpass11@192.168.90.226:8080
ENV HTTPS_PROXY http://ProxyServiceAccount:DTpass11@192.168.90.226:8080
ENV https_proxy http://ProxyServiceAccount:DTpass11@192.168.90.226:8080
ENV http_proxy http://ProxyServiceAccount:DTpass11@192.168.90.226:8080
ENV NO_PROXY localhost,10.134.8.11,10.134.8.12,10.134.8.70
ENV no_proxy localhost,10.134.8.11,10.134.8.12,10.134.8.70

RUN dpkg --add-architecture i386  # for libpam:i386
RUN apt-get update
# strace is helpful, since db2 clp can't write to docker stdout for some reason
# if you need to see docker output, must use `strace -f "db2 something" | grep write`.
RUN apt-get -y install libaio1 libnuma1 binutils strace libpam0g:i386
RUN ln -s /lib/i386-linux-gnu/libpam.so.0 /lib/libpam.so.0
#RUN ldconfig  # i686-linux-gnu.conf gets dropped into /etc/ld.so.conf.d but libs aren't cached


# Install and configure DB2 10.5
ADD files/v10.5fp1_linuxx64_expc.tar.gz v10.5fp1_linuxx64_expc.tar.gz
ADD files/db2-expc-gen.rsp db2-expc-gen.rsp
RUN v10.5fp1_linuxx64_expc.tar.gz/expc/db2setup -r db2-expc-gen.rsp || true
ADD files/install.sh install.sh

# install databases
#RUN source /home/db2inst1/sqllib/db2profile && db2start && su -c "db2 create database sample" - db2inst1

# spawn a DB2 listener
EXPOSE 50000
# we just have to keep some process running to keep the container alive (since `db2start` daemonizes)
ENTRYPOINT /home/db2inst1/sqllib/adm/db2start && tail -f /home/db2inst1/sqllib/db2dump/db2diag.log
