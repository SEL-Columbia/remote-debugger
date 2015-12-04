#!/bin/bash

# Start UMTSKeeper & Sakis3g

echo 'starting umtskeeper'

# Using Orange Senegal defaults:
sudo /home/pi/umtskeeper/umtskeeper --sakisoperators "USBINTERFACE='3' OTHER='USBMODEM' USBMODEM='1199:68a3' APN='internet' APN_USER='internet' APN_PASS='0'" --sakisswitches "--sudo --console"

