#!/bin/bash

set -e
source exception.inc.sh  #source blog.doylenet.net/?p=275

# script to mount and extract files from a directory of floppy disk images
# in linux. 

# "THE BEER-WARE LICENSE" (Revision 42):
# all.along.the.watchtower2001+github@gmail.com wrote this code. As long as 
# you retain this notice you can do whatever you want with it. If we meet 
# some day, and you think this code is worth it, you can buy me a beer in 
# return.

if [ -a 'files.log' ] ; then
	rm 'files.log'
fi

if [ -a 'error.log' ] ; then
	rm 'error.log'
fi

IMG_DIR='write-exceptions'		# img dir
OUT_DIR='write-exceptions-out'	# extracted files dir

LOOP_DEV='/dev/loop0'
MEDIA_DEV='/media/floppy1'

# check we've been given a directory
if [ -z $IMG_DIR ] ; then 
	echo "IMG_DIR must be a directory containing IMG objects"
	exit 1
fi

if [ -z $OUT_DIR ] ; then 
	echo "You must specify a directory for output"
	exit 1
fi

if [ ! -d "$IMG_DIR" ] ; then
	echo "IMG object directory does not exist"
	exit 1
fi

if [ ! -d "$OUT_DIR" ] ; then
	echo "Output directory does not exist"
	mkdir $OUT_DIR
else
	rm -r $OUT_DIR
	mkdir $OUT_DIR
fi

DRIVE_ID="/media/"$(uuidgen -rt)
mkdir $DRIVE_ID

for f in $IMG_DIR/*
do
  echo "Creating loopback and mounting: $f at $DRIVE_ID"
  
  # Construct
  losetup /dev/loop0 $f
  
  try mount -r /dev/loop0 $DRIVE_ID || catch 1,32
  if $CAUGHT; then
  	echo -e "Error mounting: $f" '\t' $(file $f) '\t' $(ls -s $f) >> error.log
  else	  
	  # Create directory for files
	  fname=$(basename $f)
	  dname=$OUT_DIR/$fname
	  mkdir $dname
	  
	  for g in $DRIVE_ID/*
	  do
	  	target=$dname/$(basename "$g")
	  	echo -e $target '\t' $g '\t' $(file $g) >> files.log 	
	  	if [ -d "$g" ] || [ -a "$g" ] && [ -s "$g" ] ; then
	  		try $(cp -r -p "$g" $target) || catch 1
	  		if $CAUGHT ; then
	  			echo -e "cp Error: Bad file or directory KryoFlux image error: " '\t' "$f" '\t' "$g" >> error.log
	  			break
	  		fi
	  	else
	  		echo -e "Not a Dir, Not a File, ZeroSize: Bad file or directory KryoFlux image error: " '\t' "$f" '\t' "$g" >> error.log
	  		break
	  	fi
	  	  	
	  done
	  
	  sleep 3
	  
	  # Destruct
	  umount /dev/loop0
  fi
  losetup -d /dev/loop0
done

rm -r $DRIVE_ID

echo -e '\n' "img-exploder.sh script complete." '\n'
