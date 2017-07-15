#! /bin/sh
svnserve -d -r /var/svn --log-file /dev/stdout --foreground
service apache2 start
