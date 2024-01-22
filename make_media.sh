#!/bin/bash

set -eu

ARG_SRC_MEDIA_PATH=$(readlink -f $1)
ARG_SRC_MEDIA_NAME=$(basename $ARG_SRC_MEDIA_PATH)
ARG_LENGTH=30

cd $(dirname $0)

# rm -rf var
mkdir -p var
ffmpeg -i $ARG_SRC_MEDIA_PATH -ss 0 -t 30 -c copy var/$ARG_SRC_MEDIA_NAME.cut.mp4
mp4fragment --fragment-duration 5000 var/$ARG_SRC_MEDIA_NAME.cut.mp4 var/$ARG_SRC_MEDIA_NAME.frag.fmp4
# rm -rf docs/media/$ARG_SRC_MEDIA_NAME
mp4dash var/$ARG_SRC_MEDIA_NAME.frag.fmp4 -o docs/media/$ARG_SRC_MEDIA_NAME
mp4info var/$ARG_SRC_MEDIA_NAME.frag.fmp4 > docs/media/$ARG_SRC_MEDIA_NAME/mp4info.txt
