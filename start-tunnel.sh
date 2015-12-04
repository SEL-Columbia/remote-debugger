#!/bin/bash

while true;
do
    echo 'waiting for response from server'
    ping -c 1 159.203.95.60 > /dev/null
    if [ $? -eq 0 ]; then
        echo 'starting reverse tunnel'
        autossh -R 22222:localhost:22 ubuntu@159.203.95.60
        echo 'tunnel connection error'
        sleep 60
    fi
    sleep 5
done

