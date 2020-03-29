#!/bin/bash

CURRENT_DIR=`dirname "$BASH_SOURCE"`
COVERS_DIR="$CURRENT_DIR/.cover"

status=$2
file_path=$(echo "$@" | grep -ioE  "file .*\.(opus|ogg|aac|mp3|flac|m4a|wav)" | sed s/file\ //)
#timestamp=`date +%s`


if [ $status == "playing" ]
then
  cover_name=$(echo "$file_path" | grep -ioE  "[^/]*$")
  if [ -f "$COVERS_DIR/${cover_name}.jpg" ]
  then
      exit
  fi
  rm $COVERS_DIR/*
  ffmpeg -i "${file_path}" -an -vcodec copy "$COVERS_DIR/${cover_name}.jpg"
  if [ ! -f "$COVERS_DIR/${cover_name}.jpg" ]
  then
    file_dir=$(dirname "${file_path}")
    cp "${file_dir}/cover.jpg" $COVERS_DIR/${cover_name}.jpg || cp "${file_dir}/folder.jpg" $COVERS_DIR/${cover_name}.jpg
  fi
fi

