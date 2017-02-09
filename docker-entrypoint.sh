#!/bin/bash
set -e

readonly NAEMON_CONF_DIR=/etc/naemon/conf.d


# define sender email address for exim
if [ -z "$EMAIL_SENDER" ]
then
    echo >&2 "you need to specify EMAIL_SENDER environment variable"
    exit 1
else
    echo "using sender email: $EMAIL_SENDER"
    echo "*@* $EMAIL_SENDER Ffr" > /etc/exim/rewrite.conf
fi


# if naemon config directory is empty copy default configuration files in it
if [ ! "$(ls -A $NAEMON_CONF_DIR)" ]
then
	echo "$NAEMON_CONF_DIR is empty, creating default naemon configuration files"
	cp -r /etc/naemon/conf.d.default/* $NAEMON_CONF_DIR/
	chown -R naemon:naemon $NAEMON_CONF_DIR
else 
	echo "$NAEMON_CONF_DIR is not empty, using existing config files in it"
fi

exec "$@"
