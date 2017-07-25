#!/bin/bash
set -e

trap appStop SIGINT SIGTERM

appStart () {
  echo "Starting sonarqube..."
  set +e
  appApache2Start
  appSvnStart
}

appSvnStart () {
  echo "Starting svn..."
  svnserve -d -r /var/svn --foreground
}

appApache2Start () {
  echo "Starting apache2..."
  service apache2 restart
}

appHelp () {
  echo "Available options:"
  echo " app:start          - Starts the svn and apache2 server (default)"
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
