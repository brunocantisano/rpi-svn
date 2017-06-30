FROM resin/rpi-raspbian
MAINTAINER Bruno Cantisano <bruno.cantisano@gmail.com>

LABEL version latest
LABEL description Simple Subversion Container

RUN apt-get update \
    && apt-get install subversion -y \
    && apt-get install apache2 libapache2-svn -y \
    && echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf \
    && a2enconf fqdn \
    && /etc/init.d/apache2 restart \
    && mkdir -p /var/svn \
    && chown www-data:www-data -R /var/svn \
    && chmod 770 -R /var/svn \
    
VOLUME /var/svn

#SVN Protocol
EXPOSE 3690

#HTTP
EXPOSE 80

#HTTPS
EXPOSE 443

CMD svnserve -d -r /var/svn --log-file /dev/stdout --foreground
