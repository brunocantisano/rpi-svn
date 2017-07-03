FROM resin/rpi-raspbian
MAINTAINER Bruno Cantisano <bruno.cantisano@gmail.com>

LABEL version latest
LABEL description Simple Subversion Container

RUN apt-get update \
    && apt-get install subversion -y \
    && apt-get install apache2 libapache2-svn -y \
    && mkdir ­p /var/svn \
    && echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf \
    && a2enconf fqdn \
    && /etc/init.d/apache2 restart \
    && chown www-data:www-data -R /var/svn \
    && chmod 770 -R /var/svn \
	&& echo "<Location /svn>" > /etc/apache2/mods-available/dav_svn.conf \
	&& echo "DAV svn" >> /etc/apache2/mods-available/dav_svn.conf \
	&& echo "SVNParentPath /var/svn" >> /etc/apache2/mods-available/dav_svn.conf \
	&& echo "AuthType Basic" >> /etc/apache2/mods-available/dav_svn.conf \
	&& echo "AuthName "Subversion Repository"" >> /etc/apache2/mods-available/dav_svn.conf \
	&& echo "AuthUserFile /etc/apache2/dav_svn.passwd" >> /etc/apache2/mods-available/dav_svn.conf \
	&& echo "<LimitExcept GET PROPFIND OPTIONS REPORT>" >> /etc/apache2/mods-available/dav_svn.conf \
	&& echo "Require valid-user" >> /etc/apache2/mods-available/dav_svn.conf \
	&& echo "</LimitExcept>" >> /etc/apache2/mods-available/dav_svn.conf \
	&& echo "</Location>" >> /etc/apache2/mods-available/dav_svn.conf \
	&& /etc/init.d/apache2 reload

VOLUME /var/svn

#SVN Protocol
EXPOSE 3690

#HTTP
EXPOSE 80

#HTTPS
EXPOSE 443

CMD svnserve -d -r /var/svn --log-file /dev/stdout --foreground
CMD apache2 start