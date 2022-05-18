# Subversion

![rpi-svn](https://img.shields.io/docker/pulls/paperinik/rpi-svn)

![docker_logo](https://raw.githubusercontent.com/brunocantisano/rpi-svn/master/files/docker.png)![docker_svn_logo](https://raw.githubusercontent.com/brunocantisano/rpi-svn/master/files/logo-svn.png)![docker_paperinik_logo](https://raw.githubusercontent.com/brunocantisano/rpi-svn/master/files/docker_paperinik_120x120.png)

This Docker container implements a subversion server (svnserve)

 * Raspbian base image: [resin/rpi-raspbian](https://hub.docker.com/r/resin/rpi-raspbian/)
 
### Installation from [Docker registry hub](https://registry.hub.docker.com/u/paperinik/rpi-svn/).

You can download the image with the following command:

```bash
docker pull paperinik/rpi-svn
```

Definition
----

# How to use this image

The Svn starts listening on the default Svn port of 3690 but uses port 80 for HTTP and 443 for HTTPS on the container.

----

1) Create the container and store the data outside of your container run: 
```bash
docker run -d -p 3690:3690 \
-p 9403:80 -p 443:443 \
-v /media/usbraid/svn-data:/var/svn \
-v /media/usbraid/docker/svn/log:/var/log/apache2 \
-v /media/usbraid/docker/svn/dav_svn.passwd:/etc/apache2/dav_svn.passwd \
--name svnRepo paperinik/rpi-svn
```
----

2) The script "run-param.sh" needs two arguments:

* First:  Name for the container (e.g. svnRepo). 
* Second: Path where the data should be stored. 
```bash
    ./run.sh svnRepo /docker-data/subversion
```
----

3) Create a new repository
```bash
docker exec -it CONTAINER_ID svnadmin create /var/svn/repo-name
```
----

4) Create password
```bash
docker exec -it CONTAINER_ID htpasswd -c /etc/apache2/dav_svn.passwd usertest
```

5) Permissions

```bash
sudo chown www-data:www-data -r svn
sudo chmod 711 -R svn
sudo chmod 711 -R svn-data
```
