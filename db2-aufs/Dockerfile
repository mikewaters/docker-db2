# Base DB2 server docker image
FROM ubuntu:trusty
MAINTAINER mike@anonymoushash.com


RUN dpkg --add-architecture i386  # for libpam:i386
RUN apt-get update
# strace is helpful, since db2 clp can't write to docker stdout for some reason
# if you need to see docker output, must use `strace -f "db2 something" | grep write`.
RUN apt-get -y install libaio1 libnuma1 binutils strace libpam0g:i386
RUN ldconfig  # i686-linux-gnu.conf gets dropped into /etc/ld.so.conf.d but libs aren't cached

ADD files/v10.5fp1_linuxx64_expc.tar.gz v10.5fp1_linuxx64_expc.tar.gz
ADD files/db2expc-noinstance.rsp db2expc.rsp
RUN v10.5fp1_linuxx64_expc.tar.gz/expc/db2setup -r db2expc.rsp


VOLUME ["/db"]
ADD files/install.sh install.sh

