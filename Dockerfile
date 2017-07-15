FROM resin/rpi-raspbian
MAINTAINER Bruno Cantisano <bruno.cantisano@gmail.com>

LABEL version latest
LABEL description Simple Subversion Container

RUN apt-get update \
    && apt-get install subversion -y \
    && apt-get install apache2 libapache2-svn -y \
    && mkdir -p /var/svn \
    && echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf \
    && a2enconf fqdn \
    && chown www-data:www-data /var/svn \
    && chmod 770 /var/svn 

COPY dav_svn.conf /etc/apache2/mods-available
COPY entry_point.sh /bin/sh

VOLUME /var/svn

#SVN Protocol
EXPOSE 3690

#HTTP
EXPOSE 80

#HTTPS
EXPOSE 443

ENTRYPOINT /bin/sh/entry_point.sh

CMD svnserve -d -r /var/svn --log-file /dev/stdout --foreground
