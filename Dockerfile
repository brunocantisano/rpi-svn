FROM jsurf/rpi-raspbian:latest
MAINTAINER Bruno Cantisano <bruno.cantisano@gmail.com>

LABEL version latest
LABEL description Simple Subversion Container

ENV LANG C.UTF-8
ENV TZ America/Brazil
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN apt-get update && apt-get install -y \
    subversion \
    apache2 \
    libapache2-svn \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/svn \
    && chown www-data:www-data -R /var/svn \
    && chmod 770 -R /var/svn \
    && echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf \
    && a2enconf fqdn 

COPY dav_svn.conf /etc/apache2/mods-available

VOLUME /var/svn /etc/apache2

#SVN Protocol, HTTP and HTTPS
EXPOSE 3690 80 443

CMD apache2 -d --foreground
CMD svnserve -d -r /var/svn/ --log-file /dev/stdout --foreground
