#!/usr/bin/env bash
while inotifywait -r '.' -e modify --quiet; do
  make -i -s check
done
