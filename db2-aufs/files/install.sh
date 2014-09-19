#!/bin/bash

# at this point, the bind mount is in place at /db
# create the instance and a database
useradd -m -d "/db/db2inst1" db2inst1 -p db2inst1
/opt/ibm/db2/V10.5/instance/db2icrt -u db2inst1 -s wse db2inst1

su -l db2inst1 -c "db2start"
time su -l db2inst1 -c "db2 -v CREATE DATABASE sample"
