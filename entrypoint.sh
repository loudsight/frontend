#!/bin/bash

. /opt/myEnv.sh

from_port=8081
to_host="localhost"
to_port=8080

cd /opt/frontend/ || exit 1

while true;
do
  sleep 1
  log "starting netcat tunnel from $from_port to $to_host:$to_port on $(hostname)"
#  nc -v -l $from_port  0</opt/frontend/backpipe | nc $to_host $to_port 1>/opt/frontend/backpipeout
  nohup nc -l -p $from_port < backpipe | tee -a in | nc localhost $to_port | tee -a out.html > backpipe
  log "stopped netcat tunnel from $from_port to $to_host:$to_port on $(hostname)"
done &


trunk serve

tail -f /dev/null