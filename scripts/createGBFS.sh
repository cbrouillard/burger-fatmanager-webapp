#!/bin/bash
set -x
KITNAME=$1
shift
wine /home/cyril/fat/gbfs.exe $KITNAME "$@"
