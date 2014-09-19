## DB2 on docker

[devicemapper vs AUFS]

#### Global issues (not storage related):
1. could not allocate shared memory
   - need to use docker run --privileged=true flag

> 2014-09-17-15.46.38.365827+000 I17912E369            LEVEL: Severe
> PID     : 95                   TID : 140036191741824 PROC : db2star2
> INSTANCE: db2inst1             NODE : 000
> HOSTNAME: e12f8d659e14
> FUNCTION: DB2 UDB, base sys utilities, DB2StartMain, probe:3
> MESSAGE : ZRC=0xFFFFFB3C=-1220
>           SQL1220N  The database manager failed to allocate shared memory.

2. some stdout issues.  sometimes db2 command exits with strange errors,
but in strace you see that operation ocmpleted successfully and
db2 attempted to write the correct output to fd 1.

AUFS:
- pro: AUFS builds appear to be much faster (No benchmark though)
- con: b/c of O_DIRECT, need to use a bind mount to a host directory,
vi docker -v
problematic since you cannot even create the instance until this mount
is available.  this means that no benefit from docker fs layering for
instance + databases + data, which is probably the bulk of your
build.
- con: cannot get it to work reliably; sometimes the db2 create database 
command blocks forever, even though database has been successfully created.

IMO, mot worth it

Devicemapper:
- con: build is slower, and since its an instance-level config, 
all your builds will be slower.
- pro: db2 works almost flawlessly (--privileged notwithstanding)
- con: since build doesnt support privileged operations (see GH issue),
anything that requires a running instance will have to be scripted,
executed in a docker run, and then comited with docker commit.
