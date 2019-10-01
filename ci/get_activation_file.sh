#!/usr/bin/env bash

xvfb-run --auto-servernum --server-args='-screen 0 640x480x24' \
  /opt/Unity/Editor/Unity \
    -logFile /dev/stdout \
    -batchmode \
    -username "$UNITY_USERNAME" -password "$UNITY_PASSWORD" |
      tee unity-output.log

cat unity-output.log |
  grep 'LICENSE SYSTEM .* Posting *' |
  sed 's/.*Posting *//' > unity.alf

# Fail job if unity.alf is empty
[ -s unity.alf ]
exit $?