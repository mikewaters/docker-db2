#!/bin/bash

su -l db2inst1 -c "db2start"
su -l db2inst1 -c "db2 -v CREATE DATABASE test"
