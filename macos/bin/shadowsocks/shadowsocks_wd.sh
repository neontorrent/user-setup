#!/bin/bash

while true; do
  #Check process status
  pid=$(ps -ef | grep ssserver | grep -v grep | awk '{print $2}')
  if [[ -z $pid ]]; then
    echo "No daemon found. Starting process"
    nohup ssserver -c .ssconf > server.log &
  else
    echo "Daemon found. PID=${pid}"
  fi

  #Check log file
  fsize=$(ls -l server.log | awk '{print $5}')
  if [[ $fsize -gt 5242880 ]]; then
    mv server.log server.log.0
    cat /dev/null > server.log
  fi

  sleep 60
done
