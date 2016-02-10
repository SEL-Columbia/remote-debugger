#!/bin/bash

while true;
do
    echo 'waiting for ppp interface'
    # Check to see if ppp0 is the default gateway
    # http://stackoverflow.com/a/15973156/86568
    if [[ `ip -4 route list 0/0` == *'ppp0'* ]]; then
        echo 'starting reverse tunnel'
        autossh -R 22222:localhost:22 ubuntu@159.203.95.60
        echo 'tunnel connection error'
        sleep 60
    fi
    sleep 5
done

