#!/bin/bash
MYDIR=`dirname $0` && [ ! `echo "$0" | grep '^\/'` ] && MYDIR=`pwd`/$MYDIR

# Binary path
FBIN=$MYDIR/bin/filebrowser

# Path to the database
FB_DATABASE=$MYDIR/etc/database.db

# Users file
FB_USERS=$MYDIR/etc/users.json

# Local HTTP Port for web application
FB_PORT=8088

# FB log file
#FB_LOG=/var/log/filebrowser.log
FB_LOG=$MYDIR/log/filebrowser.log


CMD=$1

usage() { echo "usage: sh $0 start|stop|restart";  exit 1; }

case "$CMD" in
   start)
	[ -f $FB_USERS ] && echo -n "Import users ... " && $FBIN users import $FB_USERS -d $FB_DATABASE --replace && echo OK
	BACKUP=`echo $(basename $FB_USERS) | sed -e "s/json/backup.json/"`
	[ -f $BACKUP ] && mv -f $BACKUP $MYDIR/etc/
        echo -n "Lauching ... "
        $FBIN -d $FB_DATABASE -p $FB_PORT -l $FB_LOG &
        [ $? -eq 0 ] && echo OK
        ;;
   stop)
        echo -n "Stopping ... "
        PID=$(ps x | grep filebrowser | grep -v grep | sed -e "s/^ *//" | cut -d' ' -f1)
        kill -9 $PID
        [ $? -eq 0 ] && echo OK
	echo -n "Export users ... " && $FBIN users export $FB_USERS -d $FB_DATABASE && echo OK
        ;;
   restart)
        ( sh $0 stop ; sh $0 start )
        ;;
   *) usage
      exit 2
esac

exit 0
