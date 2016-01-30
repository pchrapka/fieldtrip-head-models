#!/bin/bash

TMPFILE=`mktemp`
wget ftp://ftp.fieldtriptoolbox.org/pub/fieldtrip/tutorial/Subject01.zip -O $TMPFILE
unzip -d Subject01 $TMPFILE
rm $TMPFILE
