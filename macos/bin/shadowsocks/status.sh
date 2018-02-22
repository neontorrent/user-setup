#!/bin/bash

pid=$(ps -ef | grep shadowsocks_wd.sh | grep -v grep | awk '{print $2}')
if [[ -z $pid ]]; then
  echo "Watchdog is not running."
else
  echo "Watchdog is running."
fi

pid=$(ps -ef | grep ssserver | grep -v grep | awk '{print $2}')
if [[ -z $pid ]]; then
  echo "Daemon is not running."
else
  echo "Daemon is running."
fi
