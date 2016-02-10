#!/bin/bash

# Start UMTSKeeper & Sakis3g

echo 'starting umtskeeper'

USBINTERFACE='3'
USBMODEM='1199:68a3'
APN='data641003'
APN_USER='0'
APN_PASS='0'

# Using Orange Senegal defaults:
sudo /home/pi/umtskeeper/umtskeeper --sakisoperators "USBINTERFACE='$USBINTERFACE' OTHER='USBMODEM' USBMODEM='$USBMODEM' APN='$APN' APN_USER='$APN_USER' APN_PASS='$APN_PASS'" --sakisswitches "--sudo --console"

