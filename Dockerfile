FROM resin/rpi-raspbian:latest
MAINTAINER Bruno Cantisano <bruno.cantisano@gmail.com>

LABEL version latest
LABEL description Simple Subversion Container

RUN apt-get clean && apt-get update && apt-get install -y \
    subversion \
    apache2 \
    libapache2-svn \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/svn \
    && echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf \
    && a2enconf fqdn

COPY dav_svn.conf /etc/apache2/mods-available
COPY entry_point /entry_point.sh
RUN chmod 755 /entry_point.sh

WORKDIR /var/svn

RUN service apache2 reload \
    && chown www-data:www-data -R /var/svn \
    && chmod 770 -R /var/svn
  
VOLUME /var/svn /etc/apache2 /var/log/apache2

#SVN Protocol, HTTP and HTTPS
EXPOSE 3690 80 443

ENTRYPOINT ["/entry_point.sh"]

CMD ["app:start"]