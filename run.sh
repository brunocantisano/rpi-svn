#!/bin/bash
#
if [ ! "$1" = "" ] && [ ! "$2" = "" ] && [ ! "$3" = "" ]; then
    echo -e "\ncreating container $1\n\n"
    docker run -d -p 8083:3690 -v $2:/var/svn $3:/etc/apache2/dav_svn.passwd --name $1 paperinik/rpi-svn
else
    echo -e "\nUSAGE: run.sh your-container-name your-path passwd-path \n\n"
fi
