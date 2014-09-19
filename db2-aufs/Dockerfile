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
#RUN ln -s /lib/i386-linux-gnu/libpam.so.0 /lib/libpam.so.0
RUN ldconfig  # i686-linux-gnu.conf gets dropped into /etc/ld.so.conf.d but libs aren't cached

ADD files/v10.5fp1_linuxx64_expc.tar.gz v10.5fp1_linuxx64_expc.tar.gz
ADD files/db2expc-noinstance.rsp db2expc.rsp
RUN v10.5fp1_linuxx64_expc.tar.gz/expc/db2setup -r db2expc.rsp

#RUN groupadd db2iadm1
#RUN useradd -g db2iadm1 -m -d "/db/db2inst1" db2inst1 -p db2inst1
#RUN /opt/ibm/db2/V10.5/instance/db2icrt -u db2inst1 -p 50000 -s wse db2inst1

VOLUME ["/db"]
ADD files/install.sh install.sh

# optional, could just source /db/db2inst1/sqllib/db2profile instead
ENV IBM_DB_HOME /db/db2inst1/sqllib
ENV LD_LIBRARY_PATH /opt/ibm/db2/V10.5/lib32/:/opt/ibm/db2/V10.5/lib64/:$LD_LIBRARY_PATH
ENV DB2INSTANCE db2inst1
ENV IBM_DB_LIB /db/db2inst1/sqllib/lib
ENV IBM_DB_DIR /db/db2inst1/sqllib
ENV DB2_HOME /db/db2inst1/sqllib
ENV IBM_DB_INCLUDE /db/db2inst1/sqllib/include
ENV DB2LIB /db/db2inst1/sqllib/lib

#EXPOSE 50000
#CMD ["/bin/bash"]

