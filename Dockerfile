FROM resin/rpi-raspbian
MAINTAINER Bruno Cantisano <bruno.cantisano@gmail.com>

LABEL version latest
LABEL description Simple Subversion Container

COPY dav_svn.conf /etc/apache2/mods-available
COPY entry_point.sh /

ENV APACHE_PID_FILE= 

RUN apt-get update && apt-get install -y subversion apache2 libapache2-svn \
    && chmod 755 /entry_point.sh \
    && mkdir -p /var/svn \
    && chown www-data:www-data -R /var/svn \
    && chmod 770 -R /var/svn \
    && echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf \
    && a2enconf fqdn 

VOLUME /var/svn
VOLUME /etc/apache2

#SVN Protocol
EXPOSE 3690

#HTTP
EXPOSE 80

#HTTPS
EXPOSE 443

ENTRYPOINT ["/entry_point.sh"]

CMD ["app:start"]

