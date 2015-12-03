#!/bin/bash

# Start UMTSKeeper & Sakis3g
echo 'starting umtskeeper'
sudo /home/pi/umtskeeper/umtskeeper --sakisoperators "USBINTERFACE='3' OTHER='USBMODEM' USBMODEM='1199:68a3' APN='ndo' APN_USER='0' APN_PASS='0'" --sakisswitches "--sudo --console"

