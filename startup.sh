#!/bin/sh -e

###################################################################################
# Shell script for starting Logitech Media Server. See http://downloads.slimdevices.com/
#
# Author: Dominik Liebmann
#
#
###################################################################################
/usr/sbin/squeezeboxserver --prefsdir /var/lib/squeezeboxserver/prefs --logdir /var/log/squeezeboxserver/ --cachedir /var/lib/squeezeboxserver/cache --charset=utf8 --norestart --user squeezeboxserver

