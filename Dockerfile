FROM resin/rpi-raspbian
MAINTAINER Bruno Cantisano <bruno.cantisano@gmail.com>

LABEL version latest
LABEL description Simple Subversion Container

RUN apt-get update \
    && apt-get install subversion -y \
    && apt-get install apache2 libapache2-svn -y \
    && mkdir ­p /var/svn \
    && echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf \
    && a2enconf fqdn
 
COPY dav_svn.conf /etc/apache2/mods­available/

RUN  /etc/init.d/apache2 restart

VOLUME /var/svn

EXPOSE 3690

CMD svnserve -d -r /var/svn --log-file /dev/stdout --foreground
