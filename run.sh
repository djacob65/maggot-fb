#!/bin/bash
MYDIR=`dirname $0` && [ ! `echo "$0" | grep '^\/'` ] && MYDIR=`pwd`/$MYDIR

# Binary path
FBIN=$MYDIR/bin/filebrowser

# Path to the database
FB_DATABASE=$MYDIR/etc/database.db

# Path to the data root
FB_DATADIR=/opt/data

# Local HTTP Port for web application
FB_PORT=8088

# FB log file
#FB_LOG=/var/log/filebrowser.log
FB_LOG=$MYDIR/log/filebrowser.log


CMD=$1

usage() { echo "usage: sh $0 start|stop|restart";  exit 1; }

case "$CMD" in
   start)
        echo "Lauching ... "
        $FBIN -d $FB_DATABASE -p $FB_PORT -l $FB_LOG &
        [ $? -eq 0 ] && echo OK
        ;;
   stop)
        echo "Stopping ... "
        PID=$(ps x | grep filebrowser | grep -v grep | sed -e "s/^ *//" | cut -d' ' -f1)
        kill -9 $PID
        [ $? -eq 0 ] && echo OK
        ;;
   restart)
        ( sh $0 stop ; sh $0 start )
        ;;
   *) usage
      exit 2
esac

exit 0
