FROM resin/rpi-raspbian:latest
MAINTAINER Bruno Cardoso Cantisano <bruno.cantisano@gmail.com>

LABEL version latest
LABEL description Simple Subversion Container

RUN apt-get clean \
    && apt-get -y update \
    && apt-get -y install \
    subversion \
    apache2 \
    libapache2-svn \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/svn \
    && chown -R www-data:www-data /var/svn \
    && chmod 770 -R /var/svn \
    && echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf \
    && a2enconf fqdn

COPY files/dav_svn.conf /etc/apache2/mods-available
COPY files/envvars /etc/apache2
COPY files/entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh

VOLUME /var/svn /var/log/apache2

#SVN Protocol, HTTP and HTTPS
EXPOSE 3690 80 443

ENTRYPOINT ["/entrypoint.sh"]

CMD ["app:start"]
