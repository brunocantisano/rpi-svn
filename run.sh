#!/bin/bash
#
if [ ! "$1" = "" ] && [ ! "$2" = "" ]; then
    echo -e "\ncreating container $1\n\n"
    docker run -d -p 3690:3690 -p 8083:80 -p 443:443 -v $2:/var/svn --name $1 paperinik/rpi-svn
else
    echo -e "\nUSAGE: run.sh your-container-name your-path \n\n"
fi
