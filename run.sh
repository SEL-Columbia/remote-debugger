#!/bin/bash

lxterminal -t '3g' -e /home/pi/remote-debugger/3g.sh &
lxterminal -t 'tunnel' -e /home/pi/remote-debugger/tunnel.sh &
