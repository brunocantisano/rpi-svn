docker run -d -p 3690:3690 -p 8083:80 -p 443:443 -v /media/usbraid/svn:/var/svn -v /media/usbraid/docker/svn/log:/var/log/apache2 --name svnRepo paperinik/rpi-svn
