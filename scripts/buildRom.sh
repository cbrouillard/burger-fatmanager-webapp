#!/bin/bash
set -x
GBAROMNAME=$1
echo $GBAROMNAME
shift
NBKITGBFS=$1
echo $NBKITGBFS
wine /home/cyril/fat/gbfs.exe "$NBKITGBFS.gbfs" $NBKITGBFS
shift
USERID=$1
echo $USERID
shift
cat /home/cyril/fat/FAT_default.gba "$NBKITGBFS.gbfs" "$@" > $GBAROMNAME

#clean
find /home/cyril/fat/$USERID -name "*.gbfs" -exec rm {} -rf \;
find /home/cyril/fat/$USERID -name "00infos" -exec rm {} -rf \;
find /home/cyril/fat/$USERID -name "00nbkit" -exec rm {} -rf \;
