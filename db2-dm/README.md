DB2/dt20db docker image

Run `./build revision_number` to setup container.

Notes:
  - requires devicemapper backend
  - drops requsted revision of dt20db into docker container.
  - runs the db setup (create tablespaces, databases, roles etc) in privileged mode and commits
  - runs the package binary restore in privileged mode and commits

