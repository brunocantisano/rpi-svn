#!/bin/bash
#
if [ ! "$1" = "" ] && [ ! "$2" = "" ] && [ ! "$3" = "" ]; then
    echo -e "\ncreating container $1\n\n"
    docker run -d -p 3690:3690 -p 8083:80 -p 443:443 -v $2:/var/svn -v $3:/etc/apache2 --name $1 paperinik/rpi-svn
else
    echo -e "\nUSAGE: run.sh your-container-name your-path security-path\n\n"
fi
