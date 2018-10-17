# docker-makefile

To use this makefile you have to:
- install make and docker (and have to have docker permissions)
- run 'make \<command\>'

## parameters

### NAME
- name it like you want
- for non-local use name it \<username\>/\<imagename\>

### TAG
- this should be a version number

### VOLUME
- name it really like you want
- in best case the name is connected to the usage

### MOUNTPATH
- put the filepath here, where the volume will be mounted inside the container

### LOCALPORT
- on this local port (127.0.0.1:localport) the containerport will be reachable

### CONTAINERPORT
- on this port your application is listening inside the container


### IMAGE
- best: leave it like it is

### VOLUMEMOUNTING
- these parameters will be given to docker, when it runs the container
- if you do not use any volumes, delete the right part
- if you use multiple volumes, append further -v parameters

### PORTPUBLISHING
- these parameters will be given to docker, when it runs the container
- if you do not use any port forwards, delete the right part
- if you use multiple forwards, append further -p parameters

## commands

### build
- build the container (assuming there is a Dockerfile in the same directory)
- tag it (give a name to it)

### build-nocache
- build the container like before but without using the cache

### test
- run the container with the volume mounted
- remove the container after it shuts down

### test-shell
- like test, but start an interactive bash shell inside the container

### build-test
- first build, then test the container

### deploy
- start the container in background
- define a restart policy
- assign a global name to the running container
- mount the volume

### undeploy
- try to stop the deployed (named) container
- remove the shut down container

### redeploy
- first undeploy, then redeploy the container
- equals a restart of the container, but by creating a new container
- useful, if a new container version has been built in the background

### build-redeploy
- first build, then redeploy the container
- useful to replace the container with a new version, that first needs to be build
- make sure, the newly built container has no runtime errors: There will probably be no previous version to restore
- if the built process fails, the redeployment will not happen

### clean-volume
- try to remove the volume

### clean-container
- try to remove the container

### clean
- first try to remove the volume, then the container
