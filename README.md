# docker rpi-svn, a simple raspberry pi subversion container
Runs a small subversion server (svnserve), based on [resin/rpi-raspbian](https://hub.docker.com/r/resin/rpi-raspbian/)
### Create an image and an conatiner with Script files
- The script `build.sh` creates a image from Dockerfile with the tag `paperinik/rpi-svn`. - The script `run.sh` needs two arguments. The first argument is a 
name for the container (e.g. svnRepo). The second argument is the path where the data schould stored. (e.g. ```./run.sh svnRepo /docker-data/subversion```)
### Create the container by hand
Create the container and store the data outside of your container run: ``` docker run -d -p 3690:3690 -v /data/path:/var/svn --name server-name paperinik/rpi-svn 
```
### Create a new repository
```
  docker exec -it your-container-name svnadmin create /var/svn/repo-name ```
