FROM resin/rpi-raspbian
MAINTAINER Bruno Cantisano <bruno.cantisano@gmail.com>

LABEL version latest
LABEL description Simple Subversion Container

RUN apt-get update \
    && apt-get install -y subversion \
    && mkdir ­p /var/svn \
    && apt­get install -y apache2 \
    && apt-get install -y libapache2­svn

COPY dav_svn.conf /etc/apache2/mods­available/

RUN  /etc/init.d/apache2 restart \
     && chown ­R www­data:www­data /var/svn

VOLUME /var/svn

EXPOSE 3690

CMD svnserve -d -r /var/svn --log-file /dev/stdout --foreground
