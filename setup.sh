#!/bin/bash

if [ "x$USER" != "xroot" ]; then
	sudo ./$0 "$@"
	exit 0
fi

function die()
{
	echo "Error: $@" > /dev/stderr
	exit 1
}

function gen_own_serve()
{
}

# check root directory
[ "x$(pwd)" == "x/var/www" ] || die "website must be installed to /var/www"

# check lighttpd
which lighttpd || die "can not found lighttpd"

# stop system's lighttpd serve
/etc/init.d/lighttpd stop
update-rc.d lighttpd disable

# create own serve
cp "$(pwd)/setup/lighttpd.init /etc/init.d/lighttpd-wps-community"
update-rc.d lighttpd-wps-community enable
/etc/init.d/lighttpd start
