#!/bin/bash
set -e

trap appStop SIGINT SIGTERM

appStart () {
  echo "Starting svn and apache2..."
  set +e
  svnserve -d -r /var/svn --log-file /dev/stdout --foreground
  service apache2 restart
}

appHelp () {
  echo "Available options:"
  echo " app:start          - Starts the sonarqube server (default)"
  echo " app:help           - Displays the help"
  echo " [command]          - Execute the specified linux command eg. bash."
}

case "$1" in
  app:start)
    appStart
    ;;
  app:help)
    appHelp
    ;;
  *)
    if [ -x $1 ]; then
      $1
    else
      prog=$(which $1)
      if [ -n "${prog}" ] ; then
        shift 1
        $prog $@
      else
        appHelp
      fi
    fi
    ;;
esac

exit 0
