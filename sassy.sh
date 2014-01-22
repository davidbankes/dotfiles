#!/bin/bash

CPATH="`pwd`"
#echo $CPATH
IFS='/'
COUNTER=1
WEBROOT=0

read -ra ADDR <<< "$CPATH"
for MEMBER in ${ADDR[@]}; do
	if [ "$MEMBER" == "www" ]; then
		WEBROOT="$COUNTER"
	fi
	let "COUNTER = COUNTER + 1"
done
echo "$WEBROOT"

if [ "$WEBROOT" == 0 ]
then
	echo "Web root could not be identified. Exiting."
	exit 1
fi

WEBROOT_PATH=""
COUNTER=1
for MEMBER in ${ADDR[@]}; do
	if [ $($COUNTER <= $WEBROOT)]; then
		WEBROOT_PATH="$WEBROOT_PATH/$MEMBER"
	fi		
done
echo "$WEBROOT_PATH"