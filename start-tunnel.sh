#!/bin/bash

while true;
do
    echo 'waiting for response from server'
    ping -c 1 159.203.95.60 > /dev/null && break;
    sleep 5
done

echo 'starting reverse tunnel'

autossh -R 22225:localhost:22 ubuntu@159.203.95.60
