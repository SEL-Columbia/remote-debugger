#!/bin/bash

# Tip: You can press "Ctrl + a" twice to switch between windows

# Starts a new detached screen session (-dm) named "pi" (-S) with the 
# window title "3g" (-t), and runs 3g script
screen -dmS pi -t 3g /home/pi/start-3g.sh

# Connects to existing session "pi" (-S) and runs command (-X). 
# When screen is run within screen, it creates a new window named "tunnel" (-t)
# in the current session 
screen -S pi -X screen -t tunnel /home/pi/start-tunnel.sh

# Attach to 3g window
screen -r pi -p 3g

