FROM resin/rpi-raspbian
MAINTAINER Bruno Cantisano <bruno.cantisano@gmail.com>

LABEL version latest
LABEL description Simple Subversion Container

RUN apt-get update \
    && apt-get install subversion

VOLUME /var/svn

EXPOSE 3690

CMD svnserve -d -r /var/svn/ --log-file /dev/stdout --foreground
