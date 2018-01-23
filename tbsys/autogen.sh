#!/bin/bash

if [ "$1" == "clean" ]; then
   make distclean
   rm -rf aclocal.m4 autom4te.cache config.guess config.sub configure depcomp INSTALL install-sh ltmain.sh missing config.status config.log libtool COPYING
   find . -name 'Makefile' -exec rm -f {} \;
   find . -name 'Makefile.in' -exec rm -f {} \;
   exit;
fi

libtoolize --force >/dev/null 2>&1
if [ $? != "0" ]; then
	echo "no libtoolize found, try to use glibtoolize"
	glibtoolize --force >/dev/null 2>&1
	if [ $? != "0" ]; then
		echo "no glibtoolize either, please figure it out"
		exit 2
	fi
fi
aclocal
autoconf
automake --add-missing --force
