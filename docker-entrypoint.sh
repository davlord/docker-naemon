#!/bin/bash
set -e

readonly NAEMON_CONF_DIR=/etc/naemon/conf.d
readonly THRUK_HTPASSWD=/etc/thruk/htpasswd


# define sender email address for exim
if [ -z "$EMAIL_SENDER" ]
then
    echo >&2 "you need to specify EMAIL_SENDER environment variable"
    exit 1
else
    echo "using sender email: $EMAIL_SENDER"
    echo "*@* $EMAIL_SENDER Ffr" > /etc/exim/rewrite.conf
fi


# define naemon web interface login credentials
if [ -z "$NAEMON_WEB_USER" -o -z "$NAEMON_WEB_PASSWORD" ]
then
	echo "using default naemon web interface login credentials"
	htpasswd -b -c $THRUK_HTPASSWD thrukadmin thrukadmin
else
	echo "using custom naemon web interface login credentials"
	htpasswd -b -c $THRUK_HTPASSWD "$NAEMON_WEB_USER" "$NAEMON_WEB_PASSWORD"
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
