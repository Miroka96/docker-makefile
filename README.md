# docker-makefile

To use this makefile you have to:
- install make and docker (and have to have docker permissions)
- run 'make \<command\>'

## commands

### build-container
- build the container (assuming there is a Dockerfile in the same directory)
- tag it (give a name to it)

### test-container
- run the container with the volume mounted
- remove the container after it shuts down

### build-test-container
- first build, then test the container

### deploy-container
- start the container in background
- define a restart policy
- assign a global name to the running container
- mount the volume

### undeploy-container
- try to stop the deployed (named) container
- remove the shut down container

### redeploy-container
- first undeploy, then redeploy the container
- equals a restart of the container, but by creating a new container
- useful, if a new container version has been built in the background

### build-redeploy-container
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

### install-dependencies
- in case you have any further dependencies, add them here
- useful for local builds outside docker or for the configuration script

### configure
- create a configuration script and reference it like this: 'sh configure.sh' or 
- add all configuration steps in this section