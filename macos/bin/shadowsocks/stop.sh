#!/bin/bash

pid=$(ps -ef | grep shadowsocks_wd.sh | grep -v grep | awk '{print $2}')
if [[ -z $pid ]]; then
  echo "No watchdog found."
else
  echo "Watchdog found. Stopping PID=${pid}"
  kill $pid
fi

pid=$(ps -ef | grep ssserver | grep -v grep | awk '{print $2}')
if [[ -z $pid ]]; then
  echo "No daemon found."
else
  echo "Daemon found. Stopping PID=${pid}"
  kill $pid
fi
