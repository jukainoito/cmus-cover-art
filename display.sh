#!/bin/sh

CURRENT_DIR=`dirname "$BASH_SOURCE"`
COVERS_DIR="$CURRENT_DIR/.cover"

PREVIOUS=""
CURRENT=""

IMAGE_VIEWER="$CURRENT_DIR/imgcat"
# use python-imgcat
#IMAGE_VIEWER="imgcat --width `stty size| awk '{print $2}'` --height `bc -l <<< \"$(stty size| awk '{print $1}') - 1\"`"

clear
while (true)
do
    CURRENT=$(ls ${COVERS_DIR})
    if [ "$CURRENT" != "$PREVIOUS" ]
    then
      pkill -TERM -P $$
      clear
      if [ "$CURRENT" != "" ]
      then
        PREVIOUS=$CURRENT
        $IMAGE_VIEWER "$COVERS_DIR/$CURRENT" &
      else
        echo "::: NO COVER ART :::"
        PREVIOUS=""
      fi
    fi
    sleep 1
done

