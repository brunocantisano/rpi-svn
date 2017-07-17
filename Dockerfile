FROM resin/rpi-raspbian
MAINTAINER Bruno Cantisano <bruno.cantisano@gmail.com>

LABEL version latest
LABEL description Simple Subversion Container

RUN apt-get update \
    && apt-get install subversion -y \
    && apt-get install apache2 libapache2-svn -y \
    && mkdir -p /var/svn \
    && mkdir -p /var/security \
    && echo "user1:$apr1$GMl.0ZVN$fGmEz8pqrvrsygJSPVX9a/" > /var/security/.htpasswd \
    && echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf \
    && a2enconf fqdn \
    && chown www-data:www-data -R /var/svn \
    && chmod 770 -R /var/svn 

COPY dav_svn.conf /etc/apache2/mods-available
COPY entry_point.sh /

RUN chmod 755 /entry_point.sh

VOLUME /var/svn
VOLUME /var/security

#SVN Protocol
EXPOSE 3690

#HTTP
EXPOSE 80

#HTTPS
EXPOSE 443

ENTRYPOINT ["/entry_point.sh"]

CMD ["app:start"]

