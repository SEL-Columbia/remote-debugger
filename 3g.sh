#!/bin/bash

# Start UMTSKeeper & Sakis3g

echo 'starting umtskeeper'

USBINTERFACE='3'        #Sierra, ZTE
#USBINTERFACE='0'       #HUAWEI
USBMODEM='1199:68a3'    #Sierra Wireless AirCard 313U
#USBMODEM='19d2:0167'   #ZTE MF821
#USBMODEM='12d1:1506'   #HUAWEI E303e-65
CUSTOM_APN='data641003' #podsystemM2M
#CUSTOM_APN='internet'  #Orange
APN_USER='0'
APN_PASS='0'

# Using Orange Senegal defaults:
sudo /home/pi/umtskeeper/umtskeeper --sakisoperators "USBINTERFACE='$USBINTERFACE' OTHER='USBMODEM' USBMODEM='$USBMODEM' APN='CUSTOM_APN' CUSTOM_APN='$CUSTOM_APN' APN_USER='$APN_USER' APN_PASS='$APN_PASS'" --sakisswitches "--sudo --console"
