#!/bin/bash
MYDIR=`dirname $0` && [ ! `echo "$0" | grep '^\/'` ] && MYDIR=`pwd`/$MYDIR

FBIN=$MYDIR/../bin/filebrowser

# path to the data root
FB_DATADIR=/opt/data

# Path to the database
DB=$MYDIR/database.db

# Path to the branding
BRANDING=$MYDIR/../branding

[ $# -eq 1 ] && DATADIR=$1

FB_PORT=8088
NAME="Maggot Data Browser"
KEY=
SECRET=
BASEURL=/fb
ADDRESS=0.0.0.0

[ -f $DB ] && rm -f $DB
$FBIN config init -d $DB -r $FB_DATADIR -p $FB_PORT \
           --branding.name "$NAME" \
           --address $ADDRESS --baseurl $BASEURL \
           --branding.files $BRANDING --branding.disableExternal
#           --recaptcha.key $KEY --recaptcha.secret $SECRET

USER=admin
PASSWD="adminpwd"
OPT=--perm.admin
$FBIN users add $USER $PASSWD -d $DB $OPT

USER=maggot
PASSWD="maggotpwd"
SCOPE=/
OPT="--lockPassword --perm.execute=0 --perm.create=0 --perm.rename=0 --perm.modify=0 --perm.delete=0 --perm.share=0 --scope=$SCOPE"
$FBIN users add $USER "$PASSWD" -d $DB $OPT


exit 0
